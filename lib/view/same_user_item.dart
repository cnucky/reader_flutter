import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/info.dart';
import 'package:reader_flutter/page/info.dart';

Widget sameUserBookItem(
    BuildContext context, int index, SameUserBooksBean book) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return InfoPage(book.Name, book.Id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      height: 100.0,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: CachedNetworkImage(
              imageUrl: book.Img,
              fit: BoxFit.cover,
              width: 60,
              height: 80,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.Name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.only(right: 5),
                  decoration: ShapeDecoration(
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    book.Author,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: ShapeDecoration(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    book.LastChapter,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
