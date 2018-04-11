import 'package:json_annotation/json_annotation.dart';

part 'HomeEntity.g.dart';

@JsonSerializable()
class HomeEntity extends Object with _$HomeEntitySerializerMixin{

  int errorCode;
  String errorMsg;
  PageData data;

  HomeEntity(this.errorCode, this.errorMsg, this.data);

  factory HomeEntity.fromJson(Map<String, dynamic> json) => _$HomeEntityFromJson(json);
}

@JsonSerializable()
class PageData extends Object with _$PageDataSerializerMixin{

  int curPage;
  int pageCount;

  List<Data> datas;

  PageData(this.curPage, this.pageCount, this.datas);

  factory PageData.fromJson(Map<String, dynamic> json) => _$PageDataFromJson(json);
}

@JsonSerializable()
class Data extends Object with _$DataSerializerMixin{
  String link;
  String author;
  int id;
  String title;
  bool fresh;

  Data(this.link, this.author, this.id, this.title, this.fresh);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}