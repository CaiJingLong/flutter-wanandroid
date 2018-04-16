import 'package:flutter_wanandroid/helper/JsonHelper.dart';

class TreeEntity {
  String name;
  List<SubTreeEntity> children;

  TreeEntity(this.name, this.children);

  static List<TreeEntity> decode(jsonString) {
    var datas = JsonHelper.getData(jsonString);
    var list = new List<TreeEntity>();
    for (var data in datas) {
      var sub = SubTreeEntity.encode(data["children"]);
      var entity = new TreeEntity(data["name"], sub);
      list.add(entity);
    }

    return list;
  }
}

class SubTreeEntity {
  String name;
  int id;

  SubTreeEntity(this.name, this.id);

  static List<SubTreeEntity> encode(params) {
    List<SubTreeEntity> list = new List();
    for (var data in params) {
      var entity = new SubTreeEntity(data["name"], data["id"]);
      list.add(entity);
    }

    return list;
  }
}
