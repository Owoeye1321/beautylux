import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const SplashText(
      {super.key,
      required this.title,
      required this.color,
      required this.fontSize,
      required this.fontWeight});
  @override
  build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
