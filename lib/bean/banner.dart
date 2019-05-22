/// status : 1
/// info : ""
/// data : [{"type":"booklist","param":"22110","imgurl":"https://image.zsdfm.com/shudan/images/22110.jpg"},{"type":"booklist","param":"22111","imgurl":"https://image.zsdfm.com/shudan/images/22111.jpg"},{"type":"booklist","param":"22112","imgurl":"https://image.zsdfm.com/shudan/images/22112.jpg"}]

//class Banner {
//  int status;
//  String info;
//  List<DataBean> data;
//
//  static Banner fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    Banner bannerBean = Banner();
//    bannerBean.status = map['status'];
//    bannerBean.info = map['info'];
//    bannerBean.data = List()..addAll(
//      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
//    );
//    return bannerBean;
//  }
//}

/// type : "booklist"
/// param : "22110"
/// imgurl : "https://image.zsdfm.com/shudan/images/22110.jpg"

class MyBanner {
  String type;
  String param;
  String imgurl;

  static MyBanner fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MyBanner dataBean = MyBanner();
    dataBean.type = map['type'];
    dataBean.param = map['param'];
    dataBean.imgurl = map['imgurl'];
    return dataBean;
  }
}
