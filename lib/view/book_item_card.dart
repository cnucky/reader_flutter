import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';

Widget bookItemCard(BuildContext context, Book book) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: InkWell(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: book.Img,
              placeholder: (context, url) => CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                book.Name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
