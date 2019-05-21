import 'package:flutter/material.dart';

class BookRank extends StatefulWidget {
  @override
  _BookRankState createState() => _BookRankState();
}

class _BookRankState extends State<BookRank>
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
        title: Text("排行榜"),
      ),
    );
  }
}
