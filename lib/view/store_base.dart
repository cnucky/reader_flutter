import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/view/book_item_card.dart';

Widget storeBase(BuildContext context, String title, List<Book> books) {
  return books.length == 0
      ? Container()
      : Card(
          margin: EdgeInsets.all(5.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
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
          ),
        );
}
