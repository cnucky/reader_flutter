import 'package:banner/banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/banner.dart';
import 'package:reader_flutter/page/list_detail.dart';
import 'package:reader_flutter/view/load.dart';

Widget bannerWidget(BuildContext context, List<MyBanner> imgs) {
  return BannerView(
    data: imgs,
    delayTime: 3,
    scrollTime: 500,
    buildShowView: (index, data) {
      return imgs.length == 0
          ? LoadingPage()
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data.imgurl,
            );
    },
    onBannerClickListener: (index, data) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ListDetailPage(imgs[index].param);
      }));
    },
  );
}
