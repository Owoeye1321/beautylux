import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class TimeSlot extends StatelessWidget {
  final String content;
  final String slot_ref;
  const TimeSlot({super.key, required this.content, required this.slot_ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 11),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)),
      child: LogaText(
        content: content,
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
      ),
    );
  }
}
