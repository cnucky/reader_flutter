import 'package:flutter/material.dart';
import 'package:reader_flutter/constants.dart';
import 'package:reader_flutter/fragment/category.dart';
import 'package:reader_flutter/fragment/sex.dart';
import 'package:reader_flutter/fragment/list.dart';
import 'package:reader_flutter/fragment/special.dart';

class BookStore extends StatefulWidget {
  @override
  _BookStoreState createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabTitles = ["男生", "女生", "分类", "专题", "榜单"];

  @override
  void initState() {
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: TabBar(
            controller: _tabController,
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(MyIcons.searchIcon),
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              })
        ],
      ),
      body: TabBarView(controller: _tabController, children: [
        SexPage("man"),
        SexPage("lady"),
        CategoryPage(),
        SpecialPage(),
        ListPage(),
      ]),
    );
  }
}
