import 'package:flutter/material.dart';

class LogaIconButton extends StatelessWidget {
  final String trailingType;
  final String text;
  final IconData icon;
  final AssetImage image;

  const LogaIconButton(
      {super.key, required this.trailingType, required this.text, required this.image, required this.icon});

  @override
  Widget build(BuildContext context) {
    late Widget button;
    if (trailingType == "icon") {
      button = ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 30,
        ),
        label: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    } else {
      button = ElevatedButton(
        onPressed: () {},
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              fixedSize: MaterialStateProperty.all<Size?>(const Size(390, 60)),
              backgroundColor: MaterialStateProperty.all<Color?>(Theme.of(context).colorScheme.onSurface),
            ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
        ]),
      );
    }
    return button;
  }
}
