import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/list.dart';
import 'package:reader_flutter/page/list_detail.dart';

Widget bookListItem(BuildContext context, int index, BookList bookList) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ListDetailPage(bookList.ListId);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      height: 100.0,
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Hero(
            tag: bookList.ListId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: CachedNetworkImage(
                imageUrl: bookList.Cover,
                fit: BoxFit.cover,
                width: 60,
                height: 80,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bookList.Title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    bookList.Description,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
