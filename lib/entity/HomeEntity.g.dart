// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeEntity.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

HomeEntity _$HomeEntityFromJson(Map<String, dynamic> json) => new HomeEntity(
    json['errorCode'] as int,
    json['errorMsg'] as String,
    json['data'] == null
        ? null
        : new PageData.fromJson(json['data'] as Map<String, dynamic>));

abstract class _$HomeEntitySerializerMixin {
  int get errorCode;
  String get errorMsg;
  PageData get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data
      };
}

PageData _$PageDataFromJson(Map<String, dynamic> json) => new PageData(
    json['curPage'] as int,
    json['pageCount'] as int,
    (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : new Data.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$PageDataSerializerMixin {
  int get curPage;
  int get pageCount;
  List<Data> get datas;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'curPage': curPage,
        'pageCount': pageCount,
        'datas': datas
      };
}

Data _$DataFromJson(Map<String, dynamic> json) => new Data(
    json['link'] as String,
    json['author'] as String,
    json['id'] as int,
    json['title'] as String,
    json['fresh'] as bool);

abstract class _$DataSerializerMixin {
  String get link;
  String get author;
  int get id;
  String get title;
  bool get fresh;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'link': link,
        'author': author,
        'id': id,
        'title': title,
        'fresh': fresh
      };
}
