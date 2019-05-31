import 'package:flutter/material.dart';
import 'package:reader_flutter/fragment/kind_base.dart';

class CategoryRankPage extends StatefulWidget {
  @override
  _CategoryRankPageState createState() => _CategoryRankPageState();

  String categoryId;

  String categoryName;

  CategoryRankPage(this.categoryId, this.categoryName);
}

class _CategoryRankPageState extends State<CategoryRankPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  List<String> _tabTitles = ["最热", "最新", "评分", "完结"];

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
        title: Text(widget.categoryName),
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black54,
            controller: _tabController,
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CategoryKindBasePage(widget.categoryId, "hot"),
                CategoryKindBasePage(widget.categoryId, "new"),
                CategoryKindBasePage(widget.categoryId, "vote"),
                CategoryKindBasePage(widget.categoryId, "over"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
