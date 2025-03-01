import 'package:flutter/material.dart';

class LogaText extends StatelessWidget {
  final String content;
  final Color color;
  final double fontSize;
  final FontWeight fontweight;
  final bool? setMaxLine;
  final int? maxLines;
  const LogaText(
      {super.key,
      required this.content,
      required this.color,
      required this.fontSize,
      required this.fontweight,
      this.setMaxLine,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: setMaxLine == true ? maxLines : 1, // Limits text to 2 lines
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        wordSpacing: 2,
        color: color,
        fontSize: fontSize,
        fontWeight: fontweight,
      ),
    );
  }
}
