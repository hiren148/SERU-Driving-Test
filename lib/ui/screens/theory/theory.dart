import 'package:driving_test/config/colors.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/learn/learn_selector.dart';
import 'package:flutter/material.dart';

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({Key? key}) : super(key: key);

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ChapterSelector(
          (chapter) => Text(
            chapter?.name ?? 'Chapter 1',
          ),
        ),
        backgroundColor: AppColors.matisse,
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border.all(color: AppColors.matisse)),
        child: TheoryPartListSelector(
          (theoryParts) => ListView.separated(
            separatorBuilder: (_, index) => const SizedBox(
              height: 16.0,
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
                      height: 1.5,
                    ),
                  );
                case TheoryPartType.subtitle:
                  return Text(
                    theoryPart.textData ?? 'placeholder',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                      height: 1.5,
                    ),
                  );
                case TheoryPartType.content:
                  return Text(
                    theoryPart.textData ?? 'placeholder',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      height: 1.5,
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
      ),
    );
  }
}
