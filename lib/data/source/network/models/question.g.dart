// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkQuestionModel _$NetworkQuestionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id'], disallowNullValues: const ['id']);
  return NetworkQuestionModel(
    json['id'] as int,
    json['question'] as String,
    json['type'] as String,
    json['noOfAnswer'] as int,
    (json['options'] as List<dynamic>)
        .map((e) =>
            NetworkQuestionOptionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NetworkQuestionModelToJson(
        NetworkQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'type': instance.type,
      'noOfAnswer': instance.noOfAnswer,
      'options': instance.options,
    };
