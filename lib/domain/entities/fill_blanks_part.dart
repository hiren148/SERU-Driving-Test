import 'package:driving_test/domain/entities/option.dart';

class FillBlanksPart {
  final String type;
  final Option? option;
  final String content;

  FillBlanksPart({
    required this.type,
    this.option,
    required this.content,
  });
}
