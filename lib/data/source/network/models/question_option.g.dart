// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkQuestionOptionModel _$NetworkQuestionOptionModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id'], disallowNullValues: const ['id']);
  return NetworkQuestionOptionModel(
    json['id'] as int,
    json['option'] as String,
    json['isAnswer'] as bool? ?? false,
  );
}

Map<String, dynamic> _$NetworkQuestionOptionModelToJson(
        NetworkQuestionOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option': instance.option,
      'isAnswer': instance.isAnswer,
    };
