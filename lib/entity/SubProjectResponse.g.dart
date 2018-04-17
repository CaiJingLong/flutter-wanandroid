// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubProjectResponse.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

SubProjectResponse _$SubProjectResponseFromJson(Map<String, dynamic> json) =>
    new SubProjectResponse(
        json['errorCode'] as int,
        json['errorMsg'] as String,
        json['data'] == null
            ? null
            : new SubProjectPageData.fromJson(
                json['data'] as Map<String, dynamic>));

abstract class _$SubProjectResponseSerializerMixin {
  int get errorCode;
  String get errorMsg;
  SubProjectPageData get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data
      };
}

SubProjectPageData _$SubProjectPageDataFromJson(Map<String, dynamic> json) =>
    new SubProjectPageData(
        json['curPage'] as int,
        json['pageCount'] as int,
        (json['datas'] as List)
            ?.map((e) => e == null
                ? null
                : new SubProjectData.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$SubProjectPageDataSerializerMixin {
  int get curPage;
  int get pageCount;
  List<SubProjectData> get datas;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'curPage': curPage,
        'pageCount': pageCount,
        'datas': datas
      };
}

SubProjectData _$SubProjectDataFromJson(Map<String, dynamic> json) =>
    new SubProjectData(
        json['title'] as String,
        json['desc'] as String,
        json['author'] as String,
        json['envelopePic'] as String,
        json['link'] as String,
        json['projectLink'] as String);

abstract class _$SubProjectDataSerializerMixin {
  String get title;
  String get desc;
  String get author;
  String get envelopePic;
  String get link;
  String get projectLink;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'desc': desc,
        'author': author,
        'envelopePic': envelopePic,
        'link': link,
        'projectLink': projectLink
      };
}
