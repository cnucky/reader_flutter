import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/bean/list.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/book_item.dart';
import 'package:reader_flutter/view/load.dart';

class ListDetailPage extends StatefulWidget {
  final int listId;

  ListDetailPage(this.listId);

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  BookList _bookList;
  bool _isExpanded = false;
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _getListDetailData();
  }

  _getListDetailData() {
    getListDetailData(widget.listId).then((map) {
      setState(() {
        if (map['data'] != null) {
          _bookList = BookList.fromMap(map['data']);
          for (int i = 0; i < map['data']['BookList'].length; i++) {
            _books.add(Book.fromListDetailMap(map['data']['BookList'][i]));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_bookList == null || _books.length == 0)
          ? LoadingPage()
          : NestedScrollView(
              headerSliverBuilder: _sliverBuilder,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _desc(),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return new Divider(
                          height: 1.0,
                          color: Colors.black12,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return bookItem(context, _books[index], false);
                      },
                      itemCount: _books.length,
                    )
                  ],
                ),
              ),
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
                    _bookList.Description,
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
                    _bookList.Cover,
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

  Widget _info() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: widget.listId,
            child: CachedNetworkImage(
              imageUrl: _bookList.Cover,
              width: 90,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              _bookList.Title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _infoText("${_bookList.UpdateTime}"),
                Icon(
                  Icons.fiber_manual_record,
                  size: 6,
                  color: Colors.white,
                ),
                _infoText("共 ${_books.length.toString()} 本"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
