import 'package:flutter/material.dart';
import 'package:reader_flutter/fragment/acount.dart';
import 'package:reader_flutter/page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (_) => HomePage(),
        '/acount': (_) => AcountPage()
      },
    );
  }
}
