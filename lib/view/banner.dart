import 'package:banner/banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/banner.dart';

Widget bannerWidget(List<MyBanner> imgs) {
  return BannerView(
    data: imgs,
    delayTime: 3,
    scrollTime: 500,
    buildShowView: (index, data) {
      return imgs.length == 0
          ? Container()
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data.imgurl,
            );
    },
    onBannerClickListener: (index, data) {},
  );
}
