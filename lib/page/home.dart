import 'package:flutter/material.dart';
import 'package:reader_flutter/constants.dart';
import 'package:reader_flutter/fragment/found.dart';
import 'package:reader_flutter/fragment/rank.dart';
import 'package:reader_flutter/fragment/shelf.dart';
import 'package:reader_flutter/fragment/store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<Widget> _pages;
  PageController _pageController;
  var title = ["我的书架", "书架", "排行榜", "发现"];

  @override
  void initState() {
    _navigationViews = [
      NavigationIconView(
        title: '书架',
        iconData: MyIcons.shelfIcon,
        activeIconData: MyIcons.shelfIcon,
      ),
      NavigationIconView(
        title: '书城',
        iconData: MyIcons.storeIcon,
        activeIconData: MyIcons.storeIcon,
      ),
      NavigationIconView(
        title: '排行榜',
        iconData: MyIcons.rankIcon,
        activeIconData: MyIcons.rankIcon,
      ),
      NavigationIconView(
        title: '发现',
        iconData: MyIcons.foundIcon,
        activeIconData: MyIcons.foundIcon,
      )
    ];
    _pages = [
      BookShelf(),
      BookStore(),
      BookRank(),
      Found(),
    ];
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      fixedColor: AppColors.TabIconActive,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          //直接跳转
          _pageController.jumpToPage(index);
        });
      },
    );
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData iconData, IconData activeIconData})
      : item = BottomNavigationBarItem(
          icon: Icon(iconData),
          activeIcon: Icon(
            activeIconData,
            color: AppColors.TabIconActive,
          ),
          backgroundColor: Colors.white,
          title: Text(title),
        );
}
