import 'dart:ui';

class AppConstants {
  static const Size designScreenSize = Size(375, 754);

  static const String screenTypeLearn = 'LEARN';
  static const String screenTypeTest = 'TEST';

  static const String questionnaireTypeSingle = 'SINGLE';
  static const String questionnaireTypeMultiple = 'MULTIPLE';
  static const String questionnaireTypeFillBlanks = 'FILL_BLANK';

  static const String fillBlanksPartQuestion = 'QUESTION';
  static const String fillBlanksPartOption = 'OPTION';

  //TODO: add the Apple API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
  static const appleApiKey = 'apple_api_key';

  ////TODO: add the Google API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
  static const googleApiKey = 'goog_api_key';
}
