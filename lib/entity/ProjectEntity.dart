import 'package:json_annotation/json_annotation.dart';

part 'ProjectEntity.g.dart';

@JsonSerializable()
class ProjectEntity extends Object with _$ProjectEntitySerializerMixin {
  int errorCode;
  String errorMsg;

  List<ProjectData> data;

  ProjectEntity(this.errorCode, this.errorMsg, this.data);

  factory ProjectEntity.fromJson(Map<String, dynamic> json) => _$ProjectEntityFromJson(json);
}

@JsonSerializable()
class ProjectData extends Object with _$ProjectDataSerializerMixin {
  int id;
  String name;

  ProjectData(this.id, this.name);

  factory ProjectData.fromJson(Map<String, dynamic> json) => _$ProjectDataFromJson(json);
}
