import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/category.dart';
import 'package:reader_flutter/page/category_rank.dart';
import 'package:reader_flutter/util/constants.dart';
import 'package:reader_flutter/util/util.dart';

Widget categoryItem(BuildContext context, int index, MyCategory category) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return CategoryRankPage(category.Id, category.Name.toString());
      }));
    },
    child: Container(
      margin: EdgeInsets.all(5.0),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: getCompleteImgUrl(
                    "${StringConstants.categoryImages[index]}.jpg"),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    category.Name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    "共${category.Count.toString()}本",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
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
