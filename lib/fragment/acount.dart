import 'package:flutter/material.dart';
import 'package:reader_flutter/constants.dart';

class AcountPage extends StatefulWidget {
  @override
  _AcountPageState createState() => _AcountPageState();
}

class _AcountPageState extends State<AcountPage>
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
        title: Text("我的"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(MyIcons.backIcon),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
