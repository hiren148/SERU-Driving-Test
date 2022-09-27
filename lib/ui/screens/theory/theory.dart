import 'dart:convert';
import 'dart:io';

import 'package:driving_test/config/colors.dart';
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
      body: ChapterSelector((chapter) => WebView(
            initialUrl: chapter?.theory ?? '',
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
              _loadHtmlFromFile(chapter?.theoryFile);
            },
          )),
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
