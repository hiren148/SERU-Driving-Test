import 'package:driving_test/core/fade_route.dart';
import 'package:driving_test/ui/screens/home/home.dart';
import 'package:driving_test/ui/screens/questionnaire/exam_questionnaire.dart';
import 'package:driving_test/ui/screens/questionnaire/learn_questionnaire.dart';
import 'package:driving_test/ui/screens/splash/splash.dart';
import 'package:driving_test/ui/screens/success/success.dart';
import 'package:driving_test/ui/screens/theory/theory.dart';
import 'package:flutter/material.dart';

enum Routes {
  splash,
  home,
  learnQuestionnaire,
  examQuestionnaire,
  success,
  theory,
}

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String learnQuestionnaire = '/home/learn_questionnaire';
  static const String examQuestionnaire = '/home/exam_questionnaire';
  static const String success = '/home/success';
  static const String theory = '/home/theory';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.learnQuestionnaire: _Paths.learnQuestionnaire,
    Routes.examQuestionnaire: _Paths.examQuestionnaire,
    Routes.success: _Paths.success,
    Routes.theory: _Paths.theory,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: const SplashScreen());
      case _Paths.learnQuestionnaire:
        return FadeRoute(page: const LearnQuestionnaireScreen());
      case _Paths.examQuestionnaire:
        return FadeRoute(page: const ExamQuestionnaireScreen());
      case _Paths.success:
        return FadeRoute(page: const SuccessScreen());
      case _Paths.theory:
        return FadeRoute(page: const TheoryScreen());
      case _Paths.home:
      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static NavigatorState? get state => navigatorKey.currentState;

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);
}
