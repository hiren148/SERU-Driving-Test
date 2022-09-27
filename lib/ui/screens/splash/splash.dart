import 'dart:async';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChapterBloc get chapterBloc => context.read<ChapterBloc>();

  @override
  void initState() {
    scheduleMicrotask(() async {
      await AppImages.precacheAssets(context);
      chapterBloc.add(LoadStarted());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChapterStateStatusSelector(
              (status) {
                switch (status) {
                  case ChapterStateStatus.loading:
                    return _buildLoading();
                  case ChapterStateStatus.loadSuccess:
                    _redirectToHome();
                    return _buildLogo();
                  case ChapterStateStatus.loadFailure:
                    return _buildError();
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _redirectToHome() async {
    await Future.delayed(const Duration(milliseconds: 400));
    await AppNavigator.replaceWith(Routes.home);
  }

  Widget _buildLogo() {
    return Column(
      children: const <Widget>[
        Image(
          image: AppImages.imgLauncher,
          width: 96,
          height: 96,
        ),
        Text(
          'SERU Test',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      children: const <Widget>[
        Image(
          image: AppImages.imgLauncher,
          width: 96,
          height: 96,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'SERU Test',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.matisse,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _buildError() {
    return const Center(
      child: Icon(
        Icons.warning_amber_rounded,
        size: 60,
        color: Colors.black26,
      ),
    );
  }
}
