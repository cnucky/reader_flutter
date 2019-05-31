import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/info.dart';
import 'package:reader_flutter/view/same_user_item.dart';

class SameUserBooksPage extends StatelessWidget {
  List<SameUserBooksBean> sameUserBooksBeans;

  SameUserBooksPage(this.sameUserBooksBeans);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("作者还写过"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return sameUserBookItem(context, index, sameUserBooksBeans[index]);
        },
        itemCount: sameUserBooksBeans.length,
      ),
    );
  }
}
