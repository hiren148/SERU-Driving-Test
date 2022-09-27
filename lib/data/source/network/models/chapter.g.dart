// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkChapterModel _$NetworkChapterModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id'], disallowNullValues: const ['id']);
  return NetworkChapterModel(
    json['id'] as int,
    json['name'] as String,
    json['url'] as String,
    json['theory'] as String,
  );
}

Map<String, dynamic> _$NetworkChapterModelToJson(
        NetworkChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'theory': instance.theory,
    };
