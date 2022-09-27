import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/fonts.dart';
import 'package:flutter/material.dart';


class Theming{
  static const TextStyle lightText = TextStyle(
    color: AppColors.black,
    fontFamily: AppFonts.ubuntu,
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: AppColors.whiteGrey,
    brightness: Brightness.light,
    primaryColor: AppColors.matisse,
    appBarTheme: const AppBarTheme(
      toolbarTextStyle: lightText,
    ),
    textTheme: const TextTheme(
      bodyText1: lightText,
      bodyText2: lightText,
      labelMedium: lightText,
      caption: lightText,
      button: lightText,
      overline: lightText,
    ),
    scaffoldBackgroundColor: AppColors.lightGrey,
  );
}