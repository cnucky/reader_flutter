import 'package:reader_flutter/util/util.dart';

/// status : 1
/// info : "success"
/// data : {"Id":5,"Name":"完美世界","Img":"5.jpg","Author":"辰东","Desc":"完美世界最新章节列：小说《完美世界》辰东/著,完美世界全文阅读完美世界是辰东写的东方玄幻类小说..........","CId":95,"CName":"玄幻奇幻","LastTime":"11/1/2016 2:04:37 PM","FirstChapterId":1373,"LastChapter":"我的新书《圣墟》已上传","LastChapterId":4755824,"BookStatus":"完结","SameUserBooks":[{"Id":2999,"Name":"不死不灭","Author":"辰东","Img":"busibumie.jpg","LastChapterId":5073141,"LastChapter":"我的新书《圣墟》已上传","Score":0.0},{"Id":2622,"Name":"长生界","Author":"辰东","Img":"zhangshengjie.jpg","LastChapterId":5066011,"LastChapter":"我的新书《圣墟》已上传","Score":0.0},{"Id":2953,"Name":"神墓","Author":"辰东","Img":"shenmu.jpg","LastChapterId":5072499,"LastChapter":"我的新书《圣墟》现已上传","Score":0.0},{"Id":86745,"Name":"圣墟","Author":"辰东","Img":"shengxu.jpg","LastChapterId":5256817,"LastChapter":"第1403章 帝落时代","Score":0.0},{"Id":3051,"Name":"遮天","Author":"辰东","Img":"zhetian.jpg","LastChapterId":5073798,"LastChapter":"我的新书《圣墟》已上传","Score":0.0}],"SameCategoryBooks":[{"Id":307780,"Name":"奇迹的召唤师","Img":"qijidezhaohuanshi.jpg","Score":0.0},{"Id":388607,"Name":"天下第一魁","Img":"tianxiadiyikui.jpg","Score":0.0},{"Id":372160,"Name":"拜托了校长大人","Img":"baituolexiaozhangdaren.jpg","Score":0.0},{"Id":423391,"Name":"一曲诸天","Img":"yiquzhutian.jpg","Score":0.0},{"Id":307672,"Name":"万古最强宗","Img":"wanguzuiqiangzong.jpg","Score":0.0},{"Id":425171,"Name":"仙魔篆","Img":"xianmozhuan.jpg","Score":0.0},{"Id":175891,"Name":"魔道传说","Img":"modaochuanshuo.jpg","Score":0.0},{"Id":296932,"Name":"剑行","Img":"jianxing.jpg","Score":0.0},{"Id":332537,"Name":"我的地下城没有问题","Img":"wodedixiachengmeiyouwenti.jpg","Score":0.0},{"Id":374860,"Name":"摇光圣女","Img":"yaoguangshengnv.jpg","Score":0.0},{"Id":396622,"Name":"不忧离别","Img":"buyoulibie.jpg","Score":0.0},{"Id":427000,"Name":"变身超女在漫威","Img":"bianshenchaonvzaimanwei.jpg","Score":0.0}],"BookVote":{"BookId":5,"TotalScore":506,"VoterCount":58,"Score":8.7}}

/// Id : 5
/// Name : "完美世界"
/// Img : "5.jpg"
/// Author : "辰东"
/// Desc : "完美世界最新章节列：小说《完美世界》辰东/著,完美世界全文阅读完美世界是辰东写的东方玄幻类小说.........."
/// CId : 95
/// CName : "玄幻奇幻"
/// LastTime : "11/1/2016 2:04:37 PM"
/// FirstChapterId : 1373
/// LastChapter : "我的新书《圣墟》已上传"
/// LastChapterId : 4755824
/// BookStatus : "完结"
/// SameUserBooks : [{"Id":2999,"Name":"不死不灭","Author":"辰东","Img":"busibumie.jpg","LastChapterId":5073141,"LastChapter":"我的新书《圣墟》已上传","Score":0.0},{"Id":2622,"Name":"长生界","Author":"辰东","Img":"zhangshengjie.jpg","LastChapterId":5066011,"LastChapter":"我的新书《圣墟》已上传","Score":0.0},{"Id":2953,"Name":"神墓","Author":"辰东","Img":"shenmu.jpg","LastChapterId":5072499,"LastChapter":"我的新书《圣墟》现已上传","Score":0.0},{"Id":86745,"Name":"圣墟","Author":"辰东","Img":"shengxu.jpg","LastChapterId":5256817,"LastChapter":"第1403章 帝落时代","Score":0.0},{"Id":3051,"Name":"遮天","Author":"辰东","Img":"zhetian.jpg","LastChapterId":5073798,"LastChapter":"我的新书《圣墟》已上传","Score":0.0}]
/// SameCategoryBooks : [{"Id":307780,"Name":"奇迹的召唤师","Img":"qijidezhaohuanshi.jpg","Score":0.0},{"Id":388607,"Name":"天下第一魁","Img":"tianxiadiyikui.jpg","Score":0.0},{"Id":372160,"Name":"拜托了校长大人","Img":"baituolexiaozhangdaren.jpg","Score":0.0},{"Id":423391,"Name":"一曲诸天","Img":"yiquzhutian.jpg","Score":0.0},{"Id":307672,"Name":"万古最强宗","Img":"wanguzuiqiangzong.jpg","Score":0.0},{"Id":425171,"Name":"仙魔篆","Img":"xianmozhuan.jpg","Score":0.0},{"Id":175891,"Name":"魔道传说","Img":"modaochuanshuo.jpg","Score":0.0},{"Id":296932,"Name":"剑行","Img":"jianxing.jpg","Score":0.0},{"Id":332537,"Name":"我的地下城没有问题","Img":"wodedixiachengmeiyouwenti.jpg","Score":0.0},{"Id":374860,"Name":"摇光圣女","Img":"yaoguangshengnv.jpg","Score":0.0},{"Id":396622,"Name":"不忧离别","Img":"buyoulibie.jpg","Score":0.0},{"Id":427000,"Name":"变身超女在漫威","Img":"bianshenchaonvzaimanwei.jpg","Score":0.0}]
/// BookVote : {"BookId":5,"TotalScore":506,"VoterCount":58,"Score":8.7}

class BookInfo {
  int Id;
  String Name;
  String Img;
  String Author;
  String Desc;
  int CId;
  String CName;
  String LastTime;
  int FirstChapterId;
  String LastChapter;
  int LastChapterId;
  String BookStatus;
  List<SameUserBooksBean> SameUserBooks;
  List<SameCategoryBooksBean> SameCategoryBooks;
  BookVoteBean BookVote;

  static BookInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookInfo bookInfo = BookInfo();
    bookInfo.Id = map['Id'] ?? -1000;
    bookInfo.Name = map['Name'] ?? "";
    bookInfo.Author = map['Author'] ?? "";
    bookInfo.Img = getCompleteImgUrl(map['Img'].toString()) ?? "";
    bookInfo.Desc = map['Desc'] ?? "";
    bookInfo.CId = map['CId'] ?? -10000;
    bookInfo.CName = map['CName'] ?? "";
    bookInfo.LastTime = map['LastTime'] ?? "";
    bookInfo.FirstChapterId = map['FirstChapterId'] ?? -1000;
    bookInfo.LastChapter = map['LastChapter'] ?? "";
    bookInfo.LastChapterId = map['LastChapterId'] ?? -1000;
    bookInfo.BookStatus = map['BookStatus'] ?? "";
    bookInfo.SameUserBooks = List()
      ..addAll((map['SameUserBooks'] as List ?? [])
          .map((o) => SameUserBooksBean.fromMap(o)));
    bookInfo.SameCategoryBooks = List()
      ..addAll((map['SameCategoryBooks'] as List ?? [])
          .map((o) => SameCategoryBooksBean.fromMap(o)));
    bookInfo.BookVote = BookVoteBean.fromMap(map['BookVote']);
    return bookInfo;
  }
}

/// BookId : 5
/// TotalScore : 506
/// VoterCount : 58
/// Score : 8.7

class BookVoteBean {
  int BookId;
  int TotalScore;
  int VoterCount;
  double Score;

  static BookVoteBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookVoteBean bookVoteBean = BookVoteBean();
    bookVoteBean.BookId = map['BookId'] ?? -10000;
    bookVoteBean.TotalScore = map['TotalScore'] ?? -10000;
    bookVoteBean.VoterCount = map['VoterCount'] ?? -10000;
    bookVoteBean.Score = map['Score'] ?? -10000;
    return bookVoteBean;
  }
}

/// Id : 307780
/// Name : "奇迹的召唤师"
/// Img : "qijidezhaohuanshi.jpg"
/// Score : 0.0

class SameCategoryBooksBean {
  int Id;
  String Name;
  String Img;
  double Score;

  static SameCategoryBooksBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SameCategoryBooksBean sameCategoryBooksBean = SameCategoryBooksBean();
    sameCategoryBooksBean.Id = map['Id'] ?? -10000;
    sameCategoryBooksBean.Name = map['Name'] ?? "";
    sameCategoryBooksBean.Img = getCompleteImgUrl(map['Img'].toString()) ?? "";
    sameCategoryBooksBean.Score = map['Score'] ?? -10000;
    return sameCategoryBooksBean;
  }
}

/// Id : 2999
/// Name : "不死不灭"
/// Author : "辰东"
/// Img : "busibumie.jpg"
/// LastChapterId : 5073141
/// LastChapter : "我的新书《圣墟》已上传"
/// Score : 0.0

class SameUserBooksBean {
  int Id;
  String Name;
  String Author;
  String Img;
  int LastChapterId;
  String LastChapter;
  double Score;

  static SameUserBooksBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SameUserBooksBean sameUserBooksBean = SameUserBooksBean();
    sameUserBooksBean.Id = map['Id'] ?? -10000;
    sameUserBooksBean.Name = map['Name'] ?? "";
    sameUserBooksBean.Author = map['Author'] ?? "";
    sameUserBooksBean.Img = getCompleteImgUrl(map['Img'].toString()) ?? "";
    sameUserBooksBean.LastChapterId = map['LastChapterId'] ?? -10000;
    sameUserBooksBean.LastChapter = map['LastChapter'] ?? "";
    sameUserBooksBean.Score = map['Score'] ?? -1000;
    return sameUserBooksBean;
  }
}
