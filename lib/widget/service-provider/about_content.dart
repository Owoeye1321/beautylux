import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class AboutProvider extends StatelessWidget {
  final UserModel user;
  const AboutProvider({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "About",
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                  SizedBox(height: 20),
                  LogaText(
                    content: user.bio,
                    setMaxLine: true,
                    maxLines: 10,
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "Opening Hours",
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(height: 50, width: 50,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
