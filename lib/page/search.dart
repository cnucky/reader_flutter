import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/util/constants.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/book_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _queryTextController = TextEditingController();
  final _scrollController = ScrollController();
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  final List<String> _menuTitles = ["站内", "追书", "宜搜"];
  var _dropDownValue = "站内";
  var _curPage = 1;
  var _keyword = "";
  bool _noMore = false;
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    // 监听现在的位置是否下滑到了底部
//    _scrollController.addListener(() {
//      if (_scrollController.offset ==
//          _scrollController.position.maxScrollExtent) {
//        // 加载更多数据
//        ++_curPage;
//        _search();
//      }
//    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _search() {
    searchBook(_keyword, _curPage).then((map) {
      setState(() {
        if (map == null || map['data'].length == 0) {
          _noMore = true;
        } else
          for (int i = 0; i < map['data'].length; i++) {
            _noMore = false;
            _books.add(Book.fromMap(map['data'][i]));
          }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Text(_dropDownValue),
//              child: DropdownButton<String>(
//                value: _dropDownValue,
//                items: _menuTitles.map((String title) {
//                  return DropdownMenuItem<String>(
//                    value: title,
//                    child: Text(
//                      title,
//                      style: TextStyle(color: Colors.black, fontSize: 18.0),
//                    ),
//                  );
//                }).toList(),
//                onChanged: (String value) {
//                  setState(() {
//                    _dropDownValue = value;
//                  });
//                },
//              ),
            ),
            Expanded(
              child: TextField(
                maxLines: 1,
                autofocus: true,
                controller: _queryTextController,
                textInputAction: TextInputAction.search,
                cursorColor: Colors.greenAccent,
                style: TextStyle(color: Colors.white, fontSize: 20),
                onSubmitted: (q) {
                  setState(() {
                    _books.clear();
                    _curPage = 1;
                    _keyword = q;
                    _easyRefreshKey.currentState.callRefresh();
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintText: StringConstants.searchHintText),
              ),
            ),
          ],
        ),
      ),
      body: EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: ClassicsHeader(
          moreInfoColor: Colors.black,
          bgColor: Colors.white10,
          textColor: Colors.black,
          key: _headerKey,
          refreshText: "用力一点",
          refreshReadyText: "放松",
          refreshingText: "刷新中",
          refreshedText: "刷新完成",
          moreInfo: "上次刷新: %T",
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          moreInfoColor: Colors.black,
          bgColor: Colors.white10,
          textColor: Colors.black,
          key: _footerKey,
          loadText: "用力一点",
          loadReadyText: "松开得到更多",
          loadingText: "加载中",
          loadedText: "加载完成",
          noMoreText: _noMore ? "没有更多了" : "",
          moreInfo: "上次加载：%T",
          showMore: true,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return bookItem(context, _books[index], false);
          },
          itemCount: _books.length,
        ),
        onRefresh: () async {
          _books.clear();
          _curPage = 1;
          _search();
        },
        loadMore: () async {
          _curPage++;
          _search();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
