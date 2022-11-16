import 'package:flutter/material.dart';

enum TheoryPartType {
  title,
  subtitle,
  content,
  image,
}

class TheoryPart {
  final TheoryPartType type;
  final String? textData;
  final ImageProvider? imageData;

  TheoryPart(this.type, {this.textData, this.imageData});
}
