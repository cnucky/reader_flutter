import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/category.dart';
import 'package:reader_flutter/constants.dart';
import 'package:reader_flutter/util.dart';

Widget categoryItem(BuildContext context, int index, MyCategory category) {
  return Container(
    margin: EdgeInsets.all(10.0),
    height: 120,
    child: InkWell(
      onTap: () {},
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: getCompleteImgUrl(
                    "${TextConstants.categoryImages[index]}.jpg"),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(category.Name),
                  Text("共${category.Count.toString()}本"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(MyIcons.nextIcon),
            )
          ],
        ),
      ),
    ),
  );
}
