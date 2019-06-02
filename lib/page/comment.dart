import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/comment.dart';
import 'package:reader_flutter/bean/info.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/comment_item.dart';
import 'package:reader_flutter/view/load.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
  BookInfo _bookInfo;

  CommentPage(this._bookInfo);
}

class _CommentPageState extends State<CommentPage> {
  Comment _comment;

  @override
  void initState() {
    super.initState();
    _getCommentData();
  }

  _getCommentData() {
    getCommentData(widget._bookInfo.Name, widget._bookInfo.Id, 100).then((map) {
      setState(() {
        _comment = null;
        _comment = Comment.fromMap(map);
      });
    });
  }

  Future<void> _onRefresh() async {
    _getCommentData();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("评论"),
      ),
      body: _comment == null
          ? LoadingPage()
          : RefreshIndicator(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return commentItem(context, _comment.comments[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return new Divider(
                    height: 1.0,
                    color: Colors.black12,
                  );
                },
                itemCount: _comment.comments.length,
              ),
              onRefresh: _onRefresh,
            ),
    );
  }
}
