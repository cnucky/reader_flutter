import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/bean/mark.dart';
import 'package:reader_flutter/bean/volume.dart';
import 'package:reader_flutter/page/catalog.dart';
import 'package:reader_flutter/util/constants.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/util/util.dart';
import 'package:reader_flutter/view/load.dart';

class ReadPage extends StatefulWidget {
  @override
  _ReadPageState createState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return _ReadPageState();
  }

  ReadPage(this.bookId, {this.chapter});

  final int bookId;

  final Chapter chapter;
}

class _ReadPageState extends State<ReadPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  final BookSqlite _bookSqlite = BookSqlite();

  final BookMarkSqlite _bookMarkSqlite = BookMarkSqlite();

  double _letterSpacing = 2.0;
  double _lineHeight = 2.0;
  double _titleFontSize = 30.0;
  double _contentFontSize = 18.0;
  bool _isShowMenu = false;
  int _contentHeight = 0;
  bool _isDayMode = true;
  int _curPosition = 0;
  List<Volume> _volumes = [];
  List<Chapter> _chapters = [];
  Book _book;
  double _progress = 0.0;
  bool _isAdd = false;
  String _content = "";
  bool _isMark = false;

  @override
  void initState() {
    super.initState();
    /*查询是否已添加*/
    _bookSqlite.queryBookIsAdd(widget.bookId).then((isAdd) {
      _isAdd = isAdd;
      if (_isAdd) {
        _bookSqlite.getBook(widget.bookId).then((b) {
          _book = b;
        });
      }
    });
    _getChaptersData();
  }

  @override
  void dispose() {
    _bookSqlite.close();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  _getChaptersData() {
    getChaptersData(widget.bookId).then((map) {
      setState(() {
        /*获取目录列表*/
        for (int i = 0; i < map['data']['list'].length; i++) {
          _volumes.add(Volume.fromMap(map['data']['list'][i]));
        }
        for (int i = 0; i < _volumes.length; i++) {
          _chapters.add(
              Chapter(name: _volumes[i].name, isHeader: true, headerId: i));
          _chapters.addAll(_volumes[i].list);
        }
        if (widget.chapter != null) {
          /*目录跳转*/
          print("目录跳转");
          /*卷*/
          if (widget.chapter.isHeader) {
            for (int i = 0; i < _chapters.length; i++) {
              if (_chapters[i].isHeader &&
                  _chapters[i].headerId == widget.chapter.headerId) {
                _curPosition = i;
              }
            }
          } else
            /*章*/
            for (int i = 0; i < _chapters.length; i++) {
              if (widget.chapter.id.toString() == _chapters[i].id.toString()) {
                _curPosition = i;
              }
            }
        } else {
          /*直接阅读*/
          print("直接阅读");
          if (_isAdd) {
            /*已添加*/
            print("已添加");
            _curPosition = _book.position;
          } else {
            /*未添加*/
            print("未添加");
          }
        }
        _getChapterData();
      });
    });
  }

  _getChapterData() {
    setState(() {
      _progress = _curPosition / _chapters.length;
      print("阅读位置$_curPosition");
      print("阅读进度$_progress");
    });
    if (_chapters[_curPosition].isHeader) {
      setState(() {
        _content = "卷";
      });
    } else
      getChapterData(widget.bookId, _chapters[_curPosition].id.toString())
          .then((map) {
        setState(() {
          _content = map['data']['content'].toString();
        });
      });
    if (_content != "" || _content != "卷") _scrollController.jumpTo(0);
    _updateBookMark();
    if (_isAdd) {
      _updateReadProgress();
    }
  }

  Widget _contentView() {
    return Container(
      child: Text(
        _content,
        style: TextStyle(
          color: _isDayMode
              ? AppColors.DayModeTextColor
              : AppColors.NightModeTextColor,
          height: _lineHeight,
          fontSize: _contentFontSize,
          letterSpacing: _letterSpacing,
        ),
      ),
    );
  }

  Widget _titleView() {
    return Text(
      _chapters[_curPosition].name,
      style: TextStyle(
        color: _isDayMode
            ? AppColors.DayModeTextColor
            : AppColors.NightModeTextColor,
        fontSize: _titleFontSize,
        letterSpacing: 2,
      ),
    );
  }

  void onChange1(Chapter chapter) {
    setState(() {
      if (chapter != null) {
        /*目录跳转*/
        print("目录跳转");
        /*卷*/
        if (chapter.isHeader) {
          for (int i = 0; i < _chapters.length; i++) {
            if (_chapters[i].isHeader &&
                _chapters[i].headerId == chapter.headerId) {
              _curPosition = i;
            }
          }
        } else
          /*章*/
          for (int i = 0; i < _chapters.length; i++) {
            if (chapter.id.toString() == _chapters[i].id.toString()) {
              _curPosition = i;
            }
          }
        _getChapterData();
      }
    });
  }

  void onChange2(BookMark bookMark) {
    setState(() {
      if (bookMark != null) {
        for (int i = 0; i < _chapters.length; i++) {
          if (bookMark.chapterId == _chapters[i].id) {
            _curPosition = i;
          }
        }
        _getChapterData();
      }
    });
  }

  Widget iconTitle(
      BuildContext context, IconData iconData, String title, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Scaffold.of(context).openDrawer();
//            Navigator.push(context,
//                MaterialPageRoute(builder: (BuildContext context) {
//              return CatalogPage(
//                widget.bookId,
//                callBack: (Chapter chapter) => onChange(chapter),
//              );
//            }));
            break;
          case 1:
            setState(() {
              _isDayMode = !_isDayMode;
            });
            break;
          case 2:
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 10),
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: _isDayMode
                  ? AppColors.DayModeIconTitleButtonColor
                  : AppColors.NightModeIconTitleButtonColor,
            ),
            Text(
              title,
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateReadProgress() {
    /*更新阅读进度*/
    _book.position = _curPosition;
    _bookSqlite.update(_book).then((ret) {
      if (ret == 1) {
        print("更新阅读进度${_book.position}");
      }
    });
  }

  void _updateBookMark() {
    _bookMarkSqlite.queryBookMarkIsAdd(_chapters[_curPosition].id).then((bool) {
      setState(() {
        _isMark = bool;
      });
    });
  }

  Widget _topMenu() {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(MyIcons.backIcon),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          _chapters[_curPosition].isHeader
              ? Container()
              : IconButton(
                  icon: Icon(_isMark ? Icons.bookmark : Icons.bookmark_border),
                  onPressed: () {
                    Chapter chapter = _chapters[_curPosition];
                    if (!_isAdd) {
                      toast("请先添加到书架");
                    } else if (_isAdd && !_isMark) {
                      BookMark bookMark = BookMark();
                      bookMark.bookId = widget.bookId;
                      bookMark.chapterName = chapter.name;
                      bookMark.chapterId = chapter.id;
                      var now = new DateTime.now();
                      var formatter = DateFormat('yyyy-MM-dd  HH:mm:ss');
                      bookMark.addTime = formatter.format(now);
                      bookMark.desc = "";
                      _bookMarkSqlite.insert(bookMark);
                    } else if (_isMark) {
                      _bookMarkSqlite.deleteByChapterId(chapter.id);
                    }
                    _updateBookMark();
                  },
                )
        ],
        iconTheme: IconThemeData(
          color: _isDayMode
              ? AppColors.DayModeIconTitleButtonColor
              : AppColors.NightModeIconTitleButtonColor,
        ),
        backgroundColor: _isDayMode
            ? AppColors.DayModeMenuBgColor
            : AppColors.NightModeMenuBgColor,
      ),
    );
  }

  Widget _bottomMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: _isDayMode
          ? AppColors.DayModeMenuBgColor
          : AppColors.NightModeMenuBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _loadPre();
                },
                child: Text(
                  "上一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              ),
              Container(
                height: 2,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    //未拖动的颜色
                    inactiveTrackColor: _isDayMode
                        ? AppColors.DayModeInactiveTrackColor
                        : AppColors.NightModeInactiveTrackColor,
                    //已拖动的颜色
                    activeTrackColor: _isDayMode
                        ? AppColors.DayModeActiveTrackColor
                        : AppColors.NightModeActiveTrackColor,
                    //滑块颜色
                    thumbColor: _isDayMode
                        ? AppColors.DayModeActiveTrackColor
                        : AppColors.NightModeActiveTrackColor,
                  ),
                  child: Slider(
                    value: _progress,
                    onChanged: (value) {
                      setState(() {
//                        print(value);
//                        _progress = value;
//                        _curPosion = (value * _chapters.length).floor();
//                        _getChapterData();
                      });
                    },
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _loadNext();
                },
                child: Text(
                  "下一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              )
            ],
          ),
          Builder(
            builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    iconTitle(context, Icons.menu, "目录", 0),
                    iconTitle(
                        context, Icons.tonality, _isDayMode ? "夜间" : "日间", 1),
                    iconTitle(context, Icons.text_format, "设置", 2),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget reader() {
    return Container(
      color: _isDayMode ? AppColors.DayModeBgColor : AppColors.NightModeBgColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: kToolbarHeight,
              ),
              child: _content == "卷"
                  ? Center(
                      child: _titleView(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _titleView(),
                        _contentView(),
                      ],
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _loadPre();
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _loadNext();
                  },
                ),
              )
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _updateBookMark();
                    _isShowMenu = !_isShowMenu;
                    _isShowMenu
                        ? SystemChrome.setEnabledSystemUIOverlays(
                            [SystemUiOverlay.top, SystemUiOverlay.bottom])
                        : SystemChrome.setEnabledSystemUIOverlays([]);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _loadPre() {
    if (_curPosition != 0) {
      setState(() {
        _curPosition--;
        _getChapterData();
      });
    }
  }

  _loadNext() {
    if (_curPosition != _chapters.length - 1) {
      setState(() {
        _curPosition++;
        _getChapterData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _chapters.length == 0
        ? LoadingPage()
        : Scaffold(
            drawer: Drawer(
              child: CatalogPage(
                widget.bookId,
                callBack1: (Chapter chapter) => onChange1(chapter),
                callBack2: (BookMark bookMark) => onChange2(bookMark),
              ),
            ),
            body: Stack(
              children: <Widget>[
                reader(),
                _isShowMenu
                    ? Positioned(
                        child: _topMenu(),
                        top: 0,
                      )
                    : Container(),
                _isShowMenu
                    ? Positioned(
                        child: _bottomMenu(),
                        bottom: 0,
                      )
                    : Container(),
              ],
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
