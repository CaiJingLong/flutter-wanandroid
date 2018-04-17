import 'package:json_annotation/json_annotation.dart';

part 'SubProjectResponse.g.dart';

@JsonSerializable()
class SubProjectResponse extends Object with _$SubProjectResponseSerializerMixin {
  int errorCode;
  String errorMsg;
  SubProjectPageData data;

  SubProjectResponse(this.errorCode, this.errorMsg, this.data);

  factory SubProjectResponse.fromJson(Map<String, dynamic> json) => _$SubProjectResponseFromJson(json);
}

@JsonSerializable()
class SubProjectPageData extends Object with _$SubProjectPageDataSerializerMixin {
  int curPage;
  int pageCount;

  List<SubProjectData> datas;

  SubProjectPageData(this.curPage, this.pageCount, this.datas);

  factory SubProjectPageData.fromJson(Map<String, dynamic> json) => _$SubProjectPageDataFromJson(json);
}

@JsonSerializable()
class SubProjectData extends Object with _$SubProjectDataSerializerMixin {
  String title;
  String desc;
  String author;
  String envelopePic;
  String link;

  /// code link
  String projectLink;

  SubProjectData(this.title, this.desc, this.author, this.envelopePic, this.link, this.projectLink);

  factory SubProjectData.fromJson(Map<String, dynamic> json) => _$SubProjectDataFromJson(json);
}
