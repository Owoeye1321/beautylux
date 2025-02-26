import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';

class ViewProvider extends StatelessWidget {
  final UserModel user;
  const ViewProvider({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
                color: Color.fromARGB(255, 157, 59, 74).withOpacity(0.3),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.background,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 100,
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
                        color: Theme.of(context).colorScheme.background.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        Icons.favorite_border,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        Icons.map,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 450,
            bottom: 190,
            right: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 30,
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onInverseSurface,
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
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                                  fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      height: 30,
                      child: Text(
                        user.business_name,
                        maxLines: 2, // Limits text to 2 lines
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
                          fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight,
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
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                        fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
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
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(
                          Icons.local_offer,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 20,
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
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
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
