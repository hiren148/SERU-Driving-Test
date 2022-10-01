import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const home = _Image('home.png');
  static const homeOutline = _Image('home_outline.png');
  static const learn = _Image('learn.png');
  static const learnOutline = _Image('learn_outline.png');
  static const test = _Image('test.png');
  static const testOutline = _Image('test_outline.png');
  static const profile = _Image('profile.png');
  static const profileOutline = _Image('profile_outline.png');
  static const illustration = _Image('illustration.png');
  static const sign = _Image('sign.png');
  static const imgLearn = _Image('img_learn.png');
  static const imgTest = _Image('img_test.png');
  static const imgSingleChoice = _Image('img_single_choice.png');
  static const imgMultipleChoice = _Image('img_multiple_choice.png');
  static const imgFillBlank = _Image('img_fill_blank.png');
  static const imgLauncher = _Image('ic_launcher.png');
  static const bannerDashboard = _Image('banner_top.png');
  static const bannerLearn = _Image('learn_banner.png');
  static const bannerTest = _Image('test_banner.png');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(home, context);
    await precacheImage(homeOutline, context);
    await precacheImage(learn, context);
    await precacheImage(learnOutline, context);
    await precacheImage(test, context);
    await precacheImage(testOutline, context);
    await precacheImage(profile, context);
    await precacheImage(profileOutline, context);
    await precacheImage(illustration, context);
    await precacheImage(sign, context);
    await precacheImage(imgLearn, context);
    await precacheImage(imgTest, context);
    await precacheImage(imgSingleChoice, context);
    await precacheImage(imgMultipleChoice, context);
    await precacheImage(imgFillBlank, context);
    await precacheImage(imgLauncher, context);
    await precacheImage(bannerDashboard, context);
    await precacheImage(bannerLearn, context);
    await precacheImage(bannerTest, context);
  }
}
