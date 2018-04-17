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
            e == null ? null : new HomeData.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$PageDataSerializerMixin {
  int get curPage;
  int get pageCount;
  List<HomeData> get datas;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'curPage': curPage,
        'pageCount': pageCount,
        'datas': datas
      };
}

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => new HomeData(
    json['link'] as String,
    json['author'] as String,
    json['id'] as int,
    json['title'] as String,
    json['fresh'] as bool,
    json['chapterName'] as String,
    json['zan'] as int);

abstract class _$HomeDataSerializerMixin {
  String get link;
  String get author;
  int get id;
  String get title;
  bool get fresh;
  String get chapterName;
  int get zan;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'link': link,
        'author': author,
        'id': id,
        'title': title,
        'fresh': fresh,
        'chapterName': chapterName,
        'zan': zan
      };
}

HomeBannerEntity _$HomeBannerEntityFromJson(Map<String, dynamic> json) =>
    new HomeBannerEntity(
        json['errorCode'] as int,
        json['errorMsg'] as String,
        (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : new HomeBannerData.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$HomeBannerEntitySerializerMixin {
  int get errorCode;
  String get errorMsg;
  List<HomeBannerData> get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data
      };
}

HomeBannerData _$HomeBannerDataFromJson(Map<String, dynamic> json) =>
    new HomeBannerData(json['imagePath'] as String, json['url'] as String,
        json['id'] as int, json['title'] as String);

abstract class _$HomeBannerDataSerializerMixin {
  String get imagePath;
  String get url;
  int get id;
  String get title;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'imagePath': imagePath,
        'url': url,
        'id': id,
        'title': title
      };
}
