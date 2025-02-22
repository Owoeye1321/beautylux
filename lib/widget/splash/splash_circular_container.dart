import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircularIndex extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const CircularIndex({super.key, required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
