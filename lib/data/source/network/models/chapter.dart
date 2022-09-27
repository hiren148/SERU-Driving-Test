import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class NetworkChapterModel {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'theory')
  final String theory;

  NetworkChapterModel(this.id, this.name, this.url, this.theory);

  factory NetworkChapterModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkChapterModelToJson(this);
}
