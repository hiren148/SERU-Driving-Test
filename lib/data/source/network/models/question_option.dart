import 'package:json_annotation/json_annotation.dart';

part 'question_option.g.dart';

@JsonSerializable()
class NetworkQuestionOptionModel {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(name: 'option')
  final String option;

  @JsonKey(name: 'isAnswer', defaultValue: false)
  final bool isAnswer;

  NetworkQuestionOptionModel(this.id, this.option, this.isAnswer);

  factory NetworkQuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkQuestionOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkQuestionOptionModelToJson(this);
}
