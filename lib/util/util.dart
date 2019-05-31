import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reader_flutter/util/constants.dart';

String getCompleteImgUrl(String url) {
  if (url.contains(StringConstants.image_base_url) ||
      url.contains(StringConstants.image_base_url2) ||
      url.contains(StringConstants.image_base_url3))
    return url;
  else
    return StringConstants.image_base_url2 + url;
}

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      // ignore: undefined_identifier
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
