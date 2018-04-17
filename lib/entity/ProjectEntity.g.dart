// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectEntity.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

ProjectEntity _$ProjectEntityFromJson(Map<String, dynamic> json) =>
    new ProjectEntity(
        json['errorCode'] as int,
        json['errorMsg'] as String,
        (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : new ProjectData.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$ProjectEntitySerializerMixin {
  int get errorCode;
  String get errorMsg;
  List<ProjectData> get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data
      };
}

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) =>
    new ProjectData(json['id'] as int, json['name'] as String);

abstract class _$ProjectDataSerializerMixin {
  int get id;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
