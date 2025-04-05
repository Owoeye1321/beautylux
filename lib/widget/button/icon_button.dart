import 'package:flutter/material.dart';

class LogaIconButton extends StatelessWidget {
  final String trailingType;
  final String text;
  final IconData icon;
  final AssetImage image;
  Function onPressed;

  LogaIconButton(
      {super.key,
      required this.trailingType,
      required this.text,
      required this.image,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    late Widget button;
    if (trailingType == "icon") {
      button = ElevatedButton.icon(
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(fixedSize: WidgetStateProperty.all<Size?>(const Size(360, 50))),
        onPressed: () {},
        icon: Icon(
          icon,
          size: 30,
        ),
        label: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    } else {
      button = ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              fixedSize: WidgetStateProperty.all<Size?>(const Size(360, 50)),
              backgroundColor: WidgetStateProperty.all<Color?>(Theme.of(context).colorScheme.onSurface),
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
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ]),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button,
      ],
    );
  }
}
