import 'package:driving_test/config/colors.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/exam/exam_selector.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 96.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Test Completed',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ExamResultStateSelector(
              (noOfQuestions, score) => Text(
                'Score: $score / $noOfQuestions',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                AppNavigator.pop();
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.matisse,
              ),
              child: const Text(
                'Done',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
