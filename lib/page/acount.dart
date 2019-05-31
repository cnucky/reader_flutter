import 'package:flutter/material.dart';

class AcountPage extends StatefulWidget {
  @override
  _AcountPageState createState() => _AcountPageState();
}

class _AcountPageState extends State<AcountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
