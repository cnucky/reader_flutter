import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/book_item.dart';
import 'package:reader_flutter/view/load.dart';

class CategoryKindBasePage extends StatefulWidget {
  String categoryId;
  String kind;

  CategoryKindBasePage(this.categoryId, this.kind);

  @override
  _CategoryKindBasePageState createState() => _CategoryKindBasePageState();
}

class _CategoryKindBasePageState extends State<CategoryKindBasePage>
    with AutomaticKeepAliveClientMixin {
  int _curPage = 1;

  List<Book> _books = [];

  final _scrollController = ScrollController();

  bool _noMore = false;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  _getCategoryRankData() {
    getCategoryRankData(widget.categoryId, widget.kind, _curPage).then((map) {
      setState(() {
        if (map == null || map['data'].length == 0) {
          _noMore = true;
        } else
          for (int i = 0; i < map['data']['BookList'].length; i++) {
            _noMore = false;
            _books.add(Book.fromMap(map['data']['BookList'][i]));
          }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategoryRankData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _books.length == 0
        ? LoadingPage()
        : EasyRefresh(
            key: _easyRefreshKey,
            refreshHeader: ClassicsHeader(
              moreInfoColor: Colors.black,
              bgColor: Colors.white10,
              textColor: Colors.black,
              key: _headerKey,
              refreshText: "用力一点",
              refreshReadyText: "释放",
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
              loadReadyText: "释放",
              loadingText: "加载中",
              loadedText: "加载完成",
              noMoreText: _noMore ? "没有更多了" : "",
              moreInfo: "上次加载：%T",
              showMore: true,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return bookItem(context, _books[index], false);
              },
              itemCount: _books.length,
            ),
            onRefresh: () async {
              _books.clear();
              _curPage = 1;
              _getCategoryRankData();
            },
            loadMore: () async {
              _curPage++;
              _getCategoryRankData();
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
