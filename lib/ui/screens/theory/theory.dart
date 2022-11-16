import 'dart:convert';
import 'dart:io';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/learn/learn_selector.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({Key? key}) : super(key: key);

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChapterSelector(
          (chapter) => Text(
            chapter?.name ?? 'Chapter 1',
          ),
        ),
        backgroundColor: AppColors.matisse,
      ),
      body: TheoryPartListSelector(
        (theoryParts) => ListView.separated(
          separatorBuilder: (_, index) => const SizedBox(
            height: 8.0,
          ),
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            final TheoryPart theoryPart = theoryParts.elementAt(index);
            switch (theoryPart.type) {
              case TheoryPartType.title:
                return Text(
                  theoryPart.textData ?? 'placeholder',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.matisse,
                    fontSize: 22.0,
                  ),
                );
              case TheoryPartType.subtitle:
                return Text(
                  theoryPart.textData ?? 'placeholder',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 19.0,
                  ),
                );
              case TheoryPartType.content:
                return Text(
                  theoryPart.textData ?? 'placeholder',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                );
              case TheoryPartType.image:
                return Image(
                  image: theoryPart.imageData!,
                );
              default:
                return const SizedBox.shrink();
            }
          },
          itemCount: theoryParts.length,
        ),
      ),
    );
  }

  void _loadHtmlFromFile(File? theoryFile) async {
    if (theoryFile != null) {
      var fileText = await theoryFile.readAsString();
      _controller?.loadUrl(Uri.dataFromString(fileText,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    }
  }
}
