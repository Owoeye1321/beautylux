import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/slot.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/booking/review.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:toastification/toastification.dart';

class ProfileMenu extends ConsumerStatefulWidget {
  final UserModel user;
  const ProfileMenu({super.key, required this.user});
  ConsumerState<ProfileMenu> createState() => _ProfileMenu();
}

class _ProfileMenu extends ConsumerState<ProfileMenu> {
  DateTime selectedDate = DateTime.now();
  String errorMessage = '';
  fetchBoookingData(String company_id) async {
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2ExZTI2M2NlZWRlYWRkMWJhMjYyZTQiLCJuYW1lIjoiam9zaG5qb2huIiwicm9sZSI6InByb2Zlc3Npb25hbCIsImlhdCI6MTc0MjkzODc2NiwiZXhwIjoxNzQzMDI1MTY2fQ.nwlIYCGRNdrONLhtRiSYpIp-2_7JiJ-xiNpYGNA7QBU';
      await ref.read(slotProvider.notifier).getBookingTimeSlot(selectedDate, company_id, token);
      ref.read(userProvider.notifier).getServiceProviderStaffs(company_id, token);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ReviewBooking(
            company_id: company_id,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(errorMessage),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.8 * 255).toInt()),
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
                  color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.8 * 255).toInt()),
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
                  color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.8 * 255).toInt()),
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
                  color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.8 * 255).toInt()),
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
                  fetchBoookingData(widget.user.company_id);
                },
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.8 * 255).toInt()),
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
