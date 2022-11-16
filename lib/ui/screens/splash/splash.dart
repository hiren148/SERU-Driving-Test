import 'dart:async';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    scheduleMicrotask(() async {
      await AppImages.precacheAssets(context);
      await Future.delayed(const Duration(milliseconds: 600));
      await AppNavigator.replaceWith(Routes.home);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildLogo(),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
    return Column(
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          size: 72,
          color: Colors.black26,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Oops!! Something went wrong!',
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: AppColors.matisse,
          ),
          child: const Text(
            'Try again',
          ),
        ),
      ],
    );
  }
}
