import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/page/info.dart';

Widget bookItemCard(BuildContext context, Book book) {
  return Expanded(
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return InfoPage(book.name, book.id);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: book.img,
                width: 80,
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                book.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                book.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
