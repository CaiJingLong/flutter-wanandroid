import 'package:flutter_wanandroid/helper/JsonHelper.dart';

class LinkEntity {
  String link;
  String name;

  LinkEntity({this.link, this.name});

  static List<LinkEntity> decode(String responseString) {
    var datas = JsonHelper.getData(responseString);
    List<LinkEntity> list = new List();
    for (var data in datas) {
      var entity = new LinkEntity(link: data["link"], name: data["name"]);
      list.add(entity);
    }
    return list;
  }
}
