import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/info.dart';
import 'package:reader_flutter/view/same_category_item.dart';

class SameCategoryBooksPage extends StatelessWidget {
  List<SameCategoryBooksBean> sameCategoryBooks;

  SameCategoryBooksPage(this.sameCategoryBooks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("同类型推荐"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return sameCategoryBookItem(context, index, sameCategoryBooks[index]);
        },
        itemCount: sameCategoryBooks.length,
      ),
    );
  }
}
