import 'package:flutter/material.dart';

class AppColors {
  static const MainColor = Colors.red;

  static const BackgroundColor = Colors.white;
  static const AppBarColor = Colors.redAccent;

  static const TabNormal = Color(0xff3b3f47);
  static const TabActive = MainColor;

  static const VolumeColor = Color(0xfff5f7fa);

  static const BookMarkBgColor = Color(0xfff5f7fa);

  static const BookMarkColor = Colors.white;

  static const DayModeMenuBgColor = Color(0xffccb992);
  static const NightModeMenuBgColor = Colors.grey;

  static const DayModeIconTitleButtonColor = Color(0xff986600);
  static const NightModeIconTitleButtonColor = Colors.white;

  static const DayModeActiveTrackColor = Color(0xff986600);
  static const NightModeActiveTrackColor = Colors.white;

  static const DayModeInactiveTrackColor = Color(0xffdbcba8);
  static const NightModeInactiveTrackColor = Colors.grey;

  static const DayModeBgColor = Color(0xffdbcba8);
  static const NightModeBgColor = Color(0xff0d0c0d);

  static const DayModeTextColor = Colors.black87;
  static const NightModeTextColor = Colors.white70;
}

class MyIcons {
  static const IconData shelfIcon = Icons.book;
  static const IconData storeIcon = Icons.store;
  static const IconData rankIcon = Icons.insert_chart;
  static const IconData foundIcon = Icons.navigation;
  static const IconData shelfManageIcon = Icons.more_vert;
  static const IconData shelfUserIcon = Icons.account_circle;
  static const IconData backIcon = Icons.arrow_back_ios;
  static const IconData searchIcon = Icons.search;
  static const IconData nextIcon = Icons.navigate_next;
}

class StringConstants {
  static const IconFontFamily = "appIconFont";
  static const searchHintText = "搜索书名或作者";
  static const String image_base_url =
      "http://www.apporapp.cc/BookFiles/BookImages/";
  static const String image_base_url2 =
      "https://imgapi.jiaston.com/BookFiles/BookImages/";
  static const String image_base_url3 = "http://statics.zhuishushenqi.com/";

  static const List<String> categoryImages = [
    "taigushenwang",
    "yinianyongheng",
    "nitiantoushiyan",
    "daming1617",
    "maoshanzhuoguiren",
    "wangyouzhizuiqiangwaigua",
    "yulingnvdao",
    "shijiancaokongshi",
  ];
}

class DimenConstants {}
