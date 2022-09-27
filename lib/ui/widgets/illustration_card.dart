import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:flutter/material.dart';

class IllustrationCardView extends StatelessWidget {
  const IllustrationCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Image(
                    image: AppImages.illustration,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        child: Image(
                          width: 40,
                          image: AppImages.sign,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Clear SERU Driving Exam Quickly!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.matisse,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
