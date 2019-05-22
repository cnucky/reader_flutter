import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';

Widget bookItem(BuildContext context, int index, Book book) {
  return InkWell(
    highlightColor: Colors.black12,
    child: Container(
      padding: EdgeInsets.only(left: 20, top: 2, bottom: 2, right: 20),
      height: 80.0,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: (book == null || book == null || book.Img == "")
                ? Icon(
                    Icons.book,
                    size: 50,
                    color: Colors.redAccent,
                  )
                : Image.network(
                    book.Img,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
          ),
          Expanded(
            child: Container(
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
                        fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.CName + " - " + book.Author,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.blueAccent,
              ),
              onPressed: () {})
        ],
      ),
    ),
  );
}
