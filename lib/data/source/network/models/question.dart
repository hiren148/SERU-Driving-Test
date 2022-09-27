import 'package:driving_test/data/source/network/models/question_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class NetworkQuestionModel {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(name: 'question')
  final String question;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'noOfAnswer')
  final int noOfAnswer;

  @JsonKey(name: 'options')
  final List<NetworkQuestionOptionModel> options;

  NetworkQuestionModel(
      this.id, this.question, this.type, this.noOfAnswer, this.options);

  factory NetworkQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkQuestionModelToJson(this);
}
