import 'package:flutter/material.dart';

class BookStore extends StatefulWidget {
  @override
  _BookStoreState createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore>
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
        title: Text("书城"),
      ),
    );
  }
}
