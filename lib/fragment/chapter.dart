import 'package:adsorptionview_flutter/adsorptionview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:reader_flutter/bean/volume.dart';
import 'package:reader_flutter/page/read.dart';
import 'package:reader_flutter/util/constants.dart';
import 'package:reader_flutter/util/http_manager.dart';
import 'package:reader_flutter/view/load.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() => _ChapterPageState();

  final int bookId;

  final callBack;

  ChapterPage(this.bookId, this.callBack);
}

class _ChapterPageState extends State<ChapterPage>
    with AutomaticKeepAliveClientMixin {
  List<Volume> _volumes = [];
  List<Chapter> _chapters = [];

  @override
  initState() {
    super.initState();
    _getChaptersData();
  }

  _getChaptersData() {
    getChaptersData(widget.bookId).then((map) {
      for (int i = 0; i < map['data']['list'].length; i++) {
        _volumes.add(Volume.fromMap(map['data']['list'][i]));
      }
      setState(() {
        for (int i = 0; i < _volumes.length; i++) {
          _chapters.add(
            Chapter(name: _volumes[i].name, isHeader: true, headerId: i),
          );
          _chapters.addAll(_volumes[i].list);
        }
      });
    });
  }

  void change(Chapter chapter) {
    if (widget.callBack != null) {
      widget.callBack(chapter);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ReadPage(
          widget.bookId,
          chapter: chapter,
        );
      }));
    }
  }

  Widget _volumeText(Chapter chapter) {
    return InkWell(
      onTap: () {
        change(chapter);
      },
      child: Container(
        color: AppColors.VolumeColor,
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            chapter.name,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _chapterText(Chapter chapter) {
    return InkWell(
      onTap: () {
        change(chapter);
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            chapter.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _chapters.length == 0
        ? LoadingPage()
        : AdsorptionView(
            itemHeight: 60,
            adsorptionDatas: _chapters,
            generalItemChild: (Chapter chapter) {
              return _chapterText(chapter);
            },
            headChild: (Chapter chapter) {
              return _volumeText(chapter);
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
