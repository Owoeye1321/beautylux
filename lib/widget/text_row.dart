import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class RowText extends StatelessWidget {
  final String rightText;
  final String leftText;
  void Function() action;
  RowText({super.key, required this.rightText, required this.leftText, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LogaText(
          content: leftText,
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
          fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
        ),
        TextButton(
          onPressed: action,
          child: Text(
            rightText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
            ),
          ),
        ),
      ],
    );
  }
}
