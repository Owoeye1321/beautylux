import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/widget/service-provider/provider_profile.dart';

class ViewProvider extends ConsumerWidget {
  final UserModel user;
  const ViewProvider({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _showProviderProfile(UserModel user) {
      // if (ref.watch(profileProvider).token == '') {
      //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
      // } else {
      showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: 700, minWidth: double.infinity),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => ProviderProfile(
          user: user,
        ),
      );
      // }
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/view_user.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 157, 59, 74).withAlpha((0.3 * 255).toInt()),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ref.watch(displayProvider).colorScheme.surface,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ref.watch(displayProvider).colorScheme.surface.withAlpha((0.3 * 255).toInt()),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Icon(
                          Icons.chevron_left,
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ref.watch(displayProvider).colorScheme.surface.withAlpha((0.3 * 255).toInt()),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        Icons.favorite_border,
                        color: ref.watch(displayProvider).colorScheme.onPrimary.withOpacity(0.9),
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ref.watch(displayProvider).colorScheme.surface.withAlpha((0.3 * 255).toInt()),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        Icons.map,
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 400,
            bottom: Platform.isIOS ? 210 : 140,
            right: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: ref.watch(displayProvider).colorScheme.surface.withAlpha((0.7 * 255).toInt()),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hair . Facial . Nail 2+",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: ref.watch(displayProvider).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ref.watch(displayProvider).colorScheme.onInverseSurface,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              "OPEN",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: ref.watch(displayProvider).isLightMode
                                      ? ref.watch(displayProvider).colorScheme.surface
                                      : ref.watch(displayProvider).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                                  fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      child: Text(
                        user.business_name,
                        maxLines: 2, // Limits text to 2 lines
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                          fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.business_address,
                      maxLines: 2, // Limits text to 2 lines
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: ref.watch(displayProvider).colorScheme.outline,
                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                        fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "4.7(2.7)",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(
                          Icons.local_offer,
                          color: ref.watch(displayProvider).colorScheme.onPrimary,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "-58%",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: ref.watch(displayProvider).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(6 packs available)",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(Size(0, 0)),
                              maximumSize: WidgetStateProperty.all(
                                Size(300, 45),
                              ),
                            ),
                            onPressed: () {
                              _showProviderProfile(user);
                            },
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                color: ref.watch(displayProvider).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                                fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 680,
            child: GestureDetector(
              onTap: () {
                _showProviderProfile(user);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View More Details",
                    maxLines: 2, // Limits text to 2 lines
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: ref.watch(displayProvider).colorScheme.outline,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                      fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: ref.watch(displayProvider).colorScheme.outline,
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
