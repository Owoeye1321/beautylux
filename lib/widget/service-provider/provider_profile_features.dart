import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/screen/booking/review.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:badges/badges.dart' as badges;

class ProfileMenu extends ConsumerWidget {
  final UserModel user;
  const ProfileMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedService = ref.watch(bookingProvider);
    int serviceLength = selectedService.service != null ? 1 : 0;
    int productLength = selectedService.products.length as int;
    int totalCart = serviceLength + productLength;
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                height: 45,
                width: 45,
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
                height: 45,
                width: 45,
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
                height: 45,
                width: 45,
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
                  content: "Call",
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
                height: 45,
                width: 45,
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ReviewBooking()));
                },
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.green,
                          padding: EdgeInsets.all(5),
                        ),
                        badgeContent: LogaText(
                          content: "${totalCart}",
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.displaySmall?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color:
                              selectedService.service != null && selectedService.service?.service_ref != null
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Cart",
                  color: selectedService.service != null && selectedService.service?.service_ref != null
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.outline,
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
