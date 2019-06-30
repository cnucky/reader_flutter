import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/banner.dart';
import 'package:reader_flutter/page/list_detail.dart';

Widget bannerWidget(BuildContext context, List<MyBanner> imgs) {
  return CarouselSlider(
    height: 160.0,
    items: imgs.map((img) {
      return Builder(
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ListDetailPage(img.param);
                }));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img.imgurl,
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
//  return BannerView(
//    data: imgs,
//    delayTime: 3,
//    scrollTime: 500,
//    buildShowView: (index, data) {
//      return imgs.length == 0
//          ? LoadingPage()
//          : CachedNetworkImage(
//              fit: BoxFit.cover,
//              imageUrl: data.imgurl,
//            );
//    },
//    onBannerClickListener: (index, data) {
//      Navigator.push(context,
//          MaterialPageRoute(builder: (BuildContext context) {
//        return ListDetailPage(imgs[index].param);
//      }));
//    },
//  );
}
