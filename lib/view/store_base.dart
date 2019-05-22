import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/view/book_item_card.dart';

Widget storeBase(BuildContext context, String title, List<Book> books) {
  return books.length == 0
      ? Container()
      : Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context, books[0]),
                      bookItemCard(context, books[1]),
                      bookItemCard(context, books[2]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context, books[3]),
                      bookItemCard(context, books[4]),
                      bookItemCard(context, books[5]),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
}
