import 'package:flutter/material.dart';
import 'package:reader_flutter/fragment/book_mark.dart';
import 'package:reader_flutter/fragment/chapter.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();

  final int bookId;

  final callBack1;

  final callBack2;

  CatalogPage(this.bookId, {this.callBack1,this.callBack2});
}

class _CatalogPageState extends State<CatalogPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  List<String> _tabTitles = ["目录", "书签"];

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.import_export), onPressed: () {})
//        ],
        title: Container(
          width: 150,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.redAccent,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.black54,
            controller: _tabController,
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChapterPage(widget.bookId, widget.callBack1),
          BookMarkPage(widget.bookId, widget.callBack2),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
