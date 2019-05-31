import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/banner.dart';
import 'package:reader_flutter/bean/book.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/banner.dart';
import 'package:reader_flutter/view/load.dart';
import 'package:reader_flutter/view/store_base.dart';

class SexPage extends StatefulWidget {
  final String sex;

  SexPage(this.sex);

  @override
  _SexPageState createState() => _SexPageState();
}

class _SexPageState extends State<SexPage> with AutomaticKeepAliveClientMixin {
  List<Book> hot = [];
  List<Book> hotSerial = [];
  List<Book> recommend = [];
  List<Book> selected = [];
  List<MyBanner> banners = [];

  @override
  void initState() {
    super.initState();
    _getStoreSexBannerData();
    _getStoreSexData();
  }

  _getStoreSexData() {
    getStoreSexData(widget.sex).then((map) {
      setState(() {
        if (map == null || map['data'].length == 0) {
        } else
          for (int i = 0; i < map['data'][0]['Books'].length; i++) {
            hot.add(Book.fromMap(map['data'][0]['Books'][i]));
          }
        for (int i = 0; i < map['data'][1]['Books'].length; i++) {
          hotSerial.add(Book.fromMap(map['data'][1]['Books'][i]));
        }
        for (int i = 0; i < map['data'][2]['Books'].length; i++) {
          recommend.add(Book.fromMap(map['data'][2]['Books'][i]));
        }
        for (int i = 0; i < map['data'][3]['Books'].length; i++) {
          selected.add(Book.fromMap(map['data'][3]['Books'][i]));
        }
      });
    });
  }

  _getStoreSexBannerData() {
    getStoreSexBannerData(widget.sex).then((map) {
      setState(() {
        if (map == null || map['data'].length == 0) {
        } else
          for (int i = 0; i < map['data'].length; i++) {
            banners.add(MyBanner.fromMap(map['data'][i]));
          }
      });
    });
  }

  Future<void> _onRefresh() async {
    hot.clear();
    hotSerial.clear();
    recommend.clear();
    selected.clear();
    banners.clear();
    _getStoreSexBannerData();
    _getStoreSexData();
    return;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return banners.length == 0
        ? LoadingPage()
        : RefreshIndicator(
            child: ListView(
              children: <Widget>[
                bannerWidget(context, banners),
                storeBase(context, "火热新书", hot),
                storeBase(context, "热门连载", hotSerial),
                storeBase(context, "重磅推荐", recommend),
                storeBase(context, "完美精选", selected),
              ],
            ),
            onRefresh: _onRefresh,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
