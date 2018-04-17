import 'package:json_annotation/json_annotation.dart';

part 'NaviEntity.g.dart';

@JsonSerializable()
class NaviEntity extends Object with _$NaviEntitySerializerMixin {
  int errorCode;
  String errorMsg;

  List<NaviData> data;

  NaviEntity(this.errorCode, this.errorMsg, this.data);

  factory NaviEntity.fromJson(Map<String, dynamic> json) => _$NaviEntityFromJson(json);
}

@JsonSerializable()
class NaviData extends Object with _$NaviDataSerializerMixin {
  List<NaviChildData> articles;
  int cid;
  String name;

  NaviData(this.articles, this.cid, this.name);

  factory NaviData.fromJson(Map<String, dynamic> json) => _$NaviDataFromJson(json);
}

@JsonSerializable()
class NaviChildData extends Object with _$NaviChildDataSerializerMixin {
  String link;
  String title;
  bool collect;

  NaviChildData(this.link, this.title, this.collect);

  factory NaviChildData.fromJson(Map<String, dynamic> json) => _$NaviChildDataFromJson(json);
}
