import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book_list.dart';

Widget bookListItem(BuildContext context, int index, BookList bookList) {
  return InkWell(
    highlightColor: Colors.black12,
    child: Container(
      height: 80.0,
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child:
                (bookList == null || bookList == null || bookList.Cover == "")
                    ? Icon(
                        Icons.book,
                        size: 60,
                        color: Colors.redAccent,
                      )
                    : Image.network(
                        bookList.Cover,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 60,
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
