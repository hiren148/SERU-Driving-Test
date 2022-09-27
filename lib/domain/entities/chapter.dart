import 'package:flutter_cache_manager/file.dart';

class Chapter {
  final int id;
  final String name;
  final String url;
  final String theory;
  File? theoryFile;

  Chapter({
    required this.id,
    required this.name,
    required this.url,
    required this.theory,
    this.theoryFile,
  });
}
