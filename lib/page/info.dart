import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/bean/info.dart';
import 'package:reader_flutter/page/catalog.dart';
import 'package:reader_flutter/page/comment.dart';
import 'package:reader_flutter/page/read.dart';
import 'package:reader_flutter/page/same_category_books.dart';
import 'package:reader_flutter/page/same_uer_books.dart';
import 'package:reader_flutter/util/constants.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/load.dart';

class InfoPage extends StatefulWidget {
  @override
  _BookInfoState createState() => _BookInfoState();

  final String bookName;

  final int bookId;

  InfoPage(this.bookName, this.bookId);
}

class _BookInfoState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  BookInfo _bookInfo;
  bool _isExpanded = false;
  bool _isAdd = false;
  final BookSqlite bookSqlite = BookSqlite();

  @override
  void initState() {
    super.initState();
    _getInfoData();
    _getCommentData();
  }

  @override
  void dispose() {
    bookSqlite.close();
    super.dispose();
  }

  _queryIsAdd() {
    bookSqlite.queryBookIsAdd(_bookInfo.Id).then((bool) {
      setState(() {
        _isAdd = bool;
      });
    });
  }

  _getInfoData() {
    getInfoData(widget.bookId).then((map) {
      setState(() {
        if (map['data'] != null) {
          _bookInfo = BookInfo.fromMap(map['data']);
          _queryIsAdd();
        }
      });
    });
  }

  _getCommentData() {
    getCommentData(widget.bookName, widget.bookId, 3).then((map) {
      setState(() {
        print(map.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bookInfo == null
          ? LoadingPage()
          : NestedScrollView(
              headerSliverBuilder: _sliverBuilder,
              body: _body(),
            ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        expandedHeight: 220.0,
        //展开高度200
        floating: false,
        //不随着滑动隐藏标题
        pinned: true,
        //固定在顶部
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    _bookInfo.Img,
                  ),
                  fit: BoxFit.cover,
                )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              _info(),
            ],
          ),
        ),
      )
    ];
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _desc(),
              _catalog(),
              _author(),
              _category(),
              _comment(),
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 60,
                    width: 100,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        _isAdd ? Icon(Icons.check) : Icon(Icons.add),
                        _isAdd ? Text("已添加") : Text("加入书架"),
                      ],
                    ),
                  ),
                  onTap: _isAdd
                      ? () {
                          print("删除");
                          bookSqlite.delete(_bookInfo.Id).then((ret) {
                            if (ret == 1) {
                              setState(() {
                                _isAdd = !_isAdd;
                              });
                            }
                          });
                        }
                      : () {
                          print("添加");
                          Book book = Book();
                          book.id = _bookInfo.Id;
                          book.name = _bookInfo.Name.toString();
                          book.desc = _bookInfo.Desc.toString();
                          book.img = _bookInfo.Img.toString();
                          book.author = _bookInfo.Author.toString();
                          book.updateTime = _bookInfo.LastTime.toString();
                          book.lastChapter = _bookInfo.LastChapter.toString();
                          book.lastChapterId =
                              _bookInfo.LastChapterId.toString();
                          book.cname = _bookInfo.CName.toString();
                          book.bookStatus = _bookInfo.BookStatus.toString();
                          bookSqlite.insert(book).then((id) {
                            if (id == _bookInfo.Id) {
                              setState(() {
                                _isAdd = !_isAdd;
                              });
                            }
                          });
                        },

//                          bookSqlite.insert(book).then((id) {
//                            print(id);
//                            if (id == _bookInfo.Id.toString()) {
//                              setState(() {
//                                _isAdd = !_isAdd;
//                              });
//                            }
//                          });
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ReadPage(widget.bookId);
                    }));
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "立即阅读",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottom: 0,
        ),
      ],
    );
  }

  Widget _info() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: widget.bookId,
            child: CachedNetworkImage(
              imageUrl: _bookInfo.Img,
              width: 90,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              _bookInfo.Name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _infoText(_bookInfo.Author),
                Icon(
                  Icons.fiber_manual_record,
                  size: 6,
                  color: Colors.white,
                ),
                _infoText(_bookInfo.CName),
                Icon(
                  Icons.fiber_manual_record,
                  size: 6,
                  color: Colors.white,
                ),
                _infoText(_bookInfo.BookStatus),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoText(String content) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 14.0,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _desc() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _bookInfo.Desc,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.black54,
                        fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: _isExpanded ? 1000 : 3,
                  ),
                ),
                _isExpanded
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "展开",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 18.0),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _catalog() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CatalogPage(_bookInfo.Id);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(
                  "目录",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _bookInfo.LastChapter,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        _bookInfo.LastTime,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _author() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return SameUserBooksPage(_bookInfo.SameUserBooks);
            }));
          });
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "作者 - ${_bookInfo.Author}",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                Text("共有${_bookInfo.SameUserBooks.length.toString()}本作者相关书籍"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return SameCategoryBooksPage(_bookInfo.SameCategoryBooks);
            }));
          });
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "类型 - ${_bookInfo.CName}",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                    "共有${_bookInfo.SameCategoryBooks.length.toString()}本同类型推荐书籍"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comment() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CommentPage(_bookInfo);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "查看评论",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                IconButton(
                  icon: Icon(MyIcons.nextIcon),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
