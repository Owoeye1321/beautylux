import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServiceProviderTabs extends StatefulWidget {
  Function getCurrentIndex;
  ServiceProviderTabs({super.key, required this.getCurrentIndex});

  @override
  State<ServiceProviderTabs> createState() => _ServiceProviderTabsState();
}

class _ServiceProviderTabsState extends State<ServiceProviderTabs> {
  int activeIndex = 0;
  _changeIndex(int newIndex) {
    setState(() {
      activeIndex = newIndex;
      widget.getCurrentIndex(newIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).colorScheme.onPrimary;
    Color inactiveColor = Theme.of(context).colorScheme.outline;
    double fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize! as double;
    FontWeight fontWeight = Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            TextButton(
              onPressed: () {
                _changeIndex(0);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.only(top: 20)),
              ),
              child: LogaText(
                content: "Services",
                color: activeIndex == 0 ? activeColor : inactiveColor,
                fontSize: fontSize,
                fontweight: fontWeight,
              ),
            ),
            Container(
              width: 70,
              height: 3,
              decoration: BoxDecoration(
                color: activeIndex == 0 ? activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: () {
                _changeIndex(1);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.only(top: 20)),
              ),
              child: LogaText(
                content: "About",
                color: activeIndex == 1 ? activeColor : inactiveColor,
                fontSize: fontSize,
                fontweight: fontWeight,
              ),
            ),
            Container(
              width: 55,
              height: 3,
              decoration: BoxDecoration(
                color: activeIndex == 1 ? activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: () {
                _changeIndex(2);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.only(top: 20)),
              ),
              child: LogaText(
                content: "Product",
                color: activeIndex == 2 ? activeColor : inactiveColor,
                fontSize: fontSize,
                fontweight: fontWeight,
              ),
            ),
            Container(
              width: 65,
              height: 3,
              decoration: BoxDecoration(
                color: activeIndex == 2 ? activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: () {
                _changeIndex(3);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.only(top: 20)),
              ),
              child: LogaText(
                content: "Reviews",
                color: activeIndex == 3 ? activeColor : inactiveColor,
                fontSize: fontSize,
                fontweight: fontWeight,
              ),
            ),
            Container(
              width: 63,
              height: 3,
              decoration: BoxDecoration(
                color: activeIndex == 3 ? activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
