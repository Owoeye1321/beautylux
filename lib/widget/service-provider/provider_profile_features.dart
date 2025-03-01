import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ProfileMenu extends StatelessWidget {
  final UserModel user;
  const ProfileMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                ),
                child: Icon(
                  Icons.language_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Website",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                ),
                child: Image(
                  image: AssetImage('images/messages.png'),
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Message",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                ),
                child: Image(
                  image: AssetImage('images/call.png'),
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Website",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                ),
                child: Icon(
                  Icons.map_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Direction",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                ),
                child: Image(
                  image: AssetImage('images/send.png'),
                  color: Theme.of(context).colorScheme.outline,
                  height: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Share",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
