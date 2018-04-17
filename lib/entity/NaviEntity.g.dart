// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NaviEntity.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

NaviEntity _$NaviEntityFromJson(Map<String, dynamic> json) => new NaviEntity(
    json['errorCode'] as int,
    json['errorMsg'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : new NaviData.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$NaviEntitySerializerMixin {
  int get errorCode;
  String get errorMsg;
  List<NaviData> get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data
      };
}

NaviData _$NaviDataFromJson(Map<String, dynamic> json) => new NaviData(
    (json['articles'] as List)
        ?.map((e) => e == null
            ? null
            : new NaviChildData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['cid'] as int,
    json['name'] as String);

abstract class _$NaviDataSerializerMixin {
  List<NaviChildData> get articles;
  int get cid;
  String get name;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'articles': articles, 'cid': cid, 'name': name};
}

NaviChildData _$NaviChildDataFromJson(Map<String, dynamic> json) =>
    new NaviChildData(json['link'] as String, json['title'] as String,
        json['collect'] as bool);

abstract class _$NaviChildDataSerializerMixin {
  String get link;
  String get title;
  bool get collect;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'link': link, 'title': title, 'collect': collect};
}
