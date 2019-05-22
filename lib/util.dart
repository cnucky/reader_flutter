import 'package:reader_flutter/constants.dart';

String getCompleteImgUrl(String url) {
  if (url.contains(TextConstants.image_base_url) ||
      url.contains(TextConstants.image_base_url2) ||
      url.contains(TextConstants.image_base_url3))
    return url;
  else
    return TextConstants.image_base_url2 + url;
}
