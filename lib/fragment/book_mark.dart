import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/mark.dart';
import 'package:reader_flutter/util/constants.dart';

class BookMarkPage extends StatefulWidget {
  @override
  _BookMarkPageState createState() => _BookMarkPageState();

  final int bookId;
  final callBack;

  BookMarkPage(this.bookId, this.callBack);
}

class _BookMarkPageState extends State<BookMarkPage>
    with AutomaticKeepAliveClientMixin {
  List<BookMark> _bookMarks = [];
  final BookMarkSqlite bookMarkSqlite = BookMarkSqlite();

  @override
  void initState() {
    super.initState();
    if (widget.callBack != null) _query();
  }

  @override
  void dispose() {
    bookMarkSqlite.close();
    super.dispose();
  }

  _query() async {
    _bookMarks.clear();
    bookMarkSqlite.queryByBookId(widget.bookId).then(
      (bookMarks) {
        if (bookMarks != null)
          setState(
            () {
              print("共${bookMarks.length}个书签");
              _bookMarks.addAll(bookMarks);
            },
          );
      },
    );
  }

  Widget bookMarkItem(BookMark bookMark) {
    return InkWell(
      onLongPress: () {
        showAlertDialog(bookMark);
      },
      onTap: () {
        if (widget.callBack != null) {
          widget.callBack(bookMark);
          Navigator.pop(context);
        }
      },
      child: Container(
        color: AppColors.BookMarkColor,
        margin: EdgeInsets.all(10),
        height: 80.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              bookMark.chapterName,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Colors.black,
                  fontSize: 14.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              bookMark.addTime,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BookMark bookMark) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("提示"),
            content: new Text("是否删除书签 ${bookMark.chapterName}?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("返回"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("确定"),
                onPressed: () {
                  setState(() {
                    bookMarkSqlite.delete(bookMark.id);
                    Navigator.of(context).pop();
                    _query();
                  });
                },
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BookMarkBgColor,
      body: _bookMarks.length == 0
          ? Container(
              child: Center(
                child: Text(
                  "空空如也，也是一种态度",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return bookMarkItem(_bookMarks[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return new Divider(
                  height: 1.0,
                  color: Colors.black12,
                );
              },
              itemCount: _bookMarks.length,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
