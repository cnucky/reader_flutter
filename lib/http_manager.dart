import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  static const baseUrl = "https://quapp.1122dh.com";
  static const searchApi = "https://sou.jiaston.com/search.aspx";
  static const storeSexApi = "https://quapp.1122dh.com/v5/base";
  static const storeSexBannerApi = "https://quapp.1122dh.com/v5/base";
  static const categoryApi = "https://quapp.1122dh.com/BookCategory.html";
  static const listApi = "https://quapp.1122dh.com/shudan";
}

Future<Map> searchBook(String key, int page) async {
  print("searchBook");
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
  print("getStoreSexData");
  var result = await Dio().get("${Api.storeSexApi}/$sex.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getStoreSexBannerData(String sex) async {
  print("getStoreSexBannerData");
  var result = await Dio().get("${Api.storeSexBannerApi}/banner_$sex.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getCategoryData() async {
  print("getCategoryData");
  var result = await Dio().get(Api.categoryApi);
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> getListData(String sex, String kind, int page) async {
  print("getListData");
  print("${Api.listApi}/$sex/all/$kind/$page.html");
  var result = await Dio().get("${Api.listApi}/$sex/all/$kind/$page.html");
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}
