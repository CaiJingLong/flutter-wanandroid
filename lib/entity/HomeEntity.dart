import 'package:json_annotation/json_annotation.dart';

part 'HomeEntity.g.dart';

@JsonSerializable()
class HomeEntity extends Object with _$HomeEntitySerializerMixin {
  int errorCode;
  String errorMsg;
  PageData data;

  HomeEntity(this.errorCode, this.errorMsg, this.data);

  factory HomeEntity.fromJson(Map<String, dynamic> json) => _$HomeEntityFromJson(json);
}

@JsonSerializable()
class PageData extends Object with _$PageDataSerializerMixin {
  int curPage;
  int pageCount;

  List<HomeData> datas;

  PageData(this.curPage, this.pageCount, this.datas);

  factory PageData.fromJson(Map<String, dynamic> json) => _$PageDataFromJson(json);
}

@JsonSerializable()
class HomeData extends Object with _$HomeDataSerializerMixin {
  String link;
  String author;
  int id;
  String title;
  bool fresh;
  String chapterName;
  bool collect;
  int publishTime;
  int chapterId;
  int originId;

  HomeData(this.link, this.author, this.id, this.title, this.fresh, this.chapterName, this.collect, this.publishTime,this.chapterId);

  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);

  @override
  String toString() {
    return 'HomeData{link: $link, author: $author, id: $id, title: $title, fresh: $fresh, chapterName: $chapterName, collect: $collect, publishTime: $publishTime, chapterId: $chapterId, originId: $originId}';
  }


}

@JsonSerializable()
class HomeBannerEntity extends Object with _$HomeBannerEntitySerializerMixin {
  int errorCode;
  String errorMsg;
  List<HomeBannerData> data;

  HomeBannerEntity(this.errorCode, this.errorMsg, this.data);

  factory HomeBannerEntity.fromJson(Map<String, dynamic> json) => _$HomeBannerEntityFromJson(json);
}

@JsonSerializable()
class HomeBannerData extends Object with _$HomeBannerDataSerializerMixin {
  String imagePath;
  String url;
  int id;
  String title;

  HomeBannerData(this.imagePath, this.url, this.id, this.title);

  factory HomeBannerData.fromJson(Map<String, dynamic> json) => _$HomeBannerDataFromJson(json);
}
