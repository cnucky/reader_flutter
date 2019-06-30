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
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: CachedNetworkImageProvider(
                  getCompleteImgUrl(
                      "${StringConstants.categoryImages[index]}.jpg"),
                ),
                fit: BoxFit.cover,
              )),
              child: Container(
                color: Colors.black.withOpacity(.3),
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              category.Name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ));
}

//
//Card(
//child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Container(
//child: CachedNetworkImage(
//fit: BoxFit.cover,
//imageUrl: getCompleteImgUrl(
//"${StringConstants.categoryImages[index]}.jpg"),
//height: 120,
//width: 90,
//),
//),
//Container(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//children: <Widget>[
//Text(
//category.Name,
//style: TextStyle(
//fontSize: 20,
//fontWeight: FontWeight.w100,
//),
//),
//Text(
//"共${category.Count.toString()}本",
//style: TextStyle(
//fontSize: 16,
//fontWeight: FontWeight.w200,
//),
//),
//],
//),
//),
//Container(
//margin: EdgeInsets.only(right: 20),
//child: Icon(MyIcons.nextIcon),
//)
//],
//),
//),
