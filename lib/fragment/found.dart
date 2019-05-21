import 'package:flutter/material.dart';

class Found extends StatefulWidget {
  @override
  _FoundState createState() => _FoundState();
}

class _FoundState extends State<Found> with SingleTickerProviderStateMixin {
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
        title: Text("发现"),
      ),
    );
  }
}
