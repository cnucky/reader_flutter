import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reader_flutter/page/acount.dart';
import 'package:reader_flutter/page/home.dart';
import 'package:reader_flutter/page/search.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reader',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor:Colors.red,
        backgroundColor: Colors.white,
        brightness:Brightness.light,
        platform: TargetPlatform.android,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (_) => HomePage(),
        '/acount': (_) => AcountPage(),
        '/search': (_) => SearchPage(),
      },
    );
  }
}
