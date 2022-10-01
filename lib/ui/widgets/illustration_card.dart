import 'package:flutter/material.dart';

class IllustrationCardView extends StatelessWidget {
  final ImageProvider image;

  const IllustrationCardView({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: image,
        ),
      ),
    );
  }
}
