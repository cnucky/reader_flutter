import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  static const baseUrl = "https://quapp.1122dh.com";
  static const searchApi = "https://sou.jiaston.com/search.aspx";
  static const storeSexApi = "https://quapp.1122dh.com/v5/base";
  static const storeSexBannerApi = "https://quapp.1122dh.com/v5/base";
  static const categoryApi = "https://quapp.1122dh.com/BookCategory";
  static const listApi = "https://quapp.1122dh.com/shudan";
  static const rankApi = "https://quapp.1122dh.com/top";
  static const infoApi = "https://quapp.1122dh.com/info";
  static const commentApi = "http://changyan.sohu.com/api/2/topic/load";
  static const listDetailApi = "https://quapp.1122dh.com/shudan/detail";
  static const categoryRankApi = "https://quapp.1122dh.com/Categories";
  static const chaptersApi = "https://quapp.1122dh.com/book";
  static const chapterApi = "https://quapp.1122dh.com/book";
}

Future<Map> searchBook(String key, int page) async {
//  print("searchBook");
  var result = await Dio().get(Api.searchApi, queryParameters: {
    "siteid": "app2",
    "key": key,
    "page": page,
  });
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getStoreSexData(String sex) async {
//  print("getStoreSexData");
  var result = await Dio().get("${Api.storeSexApi}/$sex.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getStoreSexBannerData(String sex) async {
//  print("getStoreSexBannerData");
  var result = await Dio().get("${Api.storeSexBannerApi}/banner_$sex.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getCategoryData() async {
//  print("getCategoryData");
  var result = await Dio().get("${Api.categoryApi}.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getListData(String sex, String kind, int page) async {
//  print("getListData");
//  print("${Api.listApi}/$sex/all/$kind/$page.html");
  var result = await Dio().get("${Api.listApi}/$sex/all/$kind/$page.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getRankData(String sex, String kind, String time, int page) async {
//  top/{sex}/top/{kind}/{time}/{curpage}.html
//  print("getRankData");
//  print("${Api.rankApi}/$sex/top/$kind/$time/$page.html");
  var result =
      await Dio().get("${Api.rankApi}/$sex/top/$kind/$time/$page.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getInfoData(int bookId) async {
//  print("getInfoData");
//  print("${Api.infoApi}/$bookId.html");
  var result = await Dio().get("${Api.infoApi}/$bookId.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getCommentData(
    String topic_title, int topic_source_id, int page_size) async {
//  print("getCommentData");
  var result = await Dio().get(Api.commentApi, queryParameters: {
    'hot_size': 1,
    'depth': 0,
    'topic_url': "",
    'topic_title': topic_title,
    'order_by': "",
    'style': "",
    'sub_size': 0,
    'client_id': "cyt9aPs20",
    'topic_source_id': topic_source_id,
    'page_size': page_size,
  });
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getListDetailData(int listId) async {
//  print("getListDetailData");
  var result = await Dio().get("${Api.listDetailApi}/$listId.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getCategoryRankData(
    String categoryId, String kind, int curPage) async {
//  print("getCategoryRankData");
//  print("${Api.categoryRankApi}/$categoryId/$kind/$curPage.html");
  var result =
      await Dio().get("${Api.categoryRankApi}/$categoryId/$kind/$curPage.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getChaptersData(int bookId) async {
//  print("getChaptersData");
//  print("${Api.chaptersApi}/$bookId/");
  var result = await Dio().get("${Api.chaptersApi}/$bookId/");
  var data = result.data.toString().replaceAll(",]", "]");
  return json.decode(data);
}

Future<Map> getChapterData(int bookId, String chapterId) async {
//  print("getChapterData");
//  print("${Api.chapterApi}/$bookId/");
  var result = await Dio().get("${Api.chapterApi}/$bookId/$chapterId.html/");
  var data = result.data.toString().replaceAll(",]", "]");
  return json.decode(data);
}
