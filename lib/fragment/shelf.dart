import 'package:flutter/material.dart';
import 'package:reader_flutter/constants.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("我的书架"),
        leading: IconButton(
            icon: Icon(MyIcons.shelfUserIcon),
            onPressed: () {
              Navigator.of(context).pushNamed('/acount');
            }),
        actions: [
          IconButton(
              icon: Icon(MyIcons.shelfManageIcon),
              onPressed: () {
              }),
        ],
      ),
    );
  }
}
