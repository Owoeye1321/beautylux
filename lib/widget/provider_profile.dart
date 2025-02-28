import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';

class ProviderProfile extends StatefulWidget {
  final UserModel user;
  const ProviderProfile({super.key, required this.user});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.user.business_name,
                maxLines: 2, // Limits text to 2 lines
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                  fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
