import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/slot.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/screen/booking/review.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

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
      if (ref.read(profileProvider).token == '') {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
      } else {
        await ref
            .read(slotProvider.notifier)
            .getBookingTimeSlot(selectedDate, company_id, ref.read(profileProvider).token);
        ref.read(userProvider.notifier).getServiceProviderStaffs(company_id, ref.read(profileProvider).token);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ReviewBooking(
              company_id: company_id,
            ),
          ),
        );
      }
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

  Future<void> launchEmail() async {
    final String email = Uri.encodeComponent(widget.user.email);
    final String subject = Uri.encodeComponent("Service Request");
    final Uri mail = Uri.parse("mailto:$email?subject=$subject");

    try {
      final bool launched = await launchUrl(mail);
      if (launched) {
        // email app opened
      } else {
        // email app is not opened
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          title: Text('Could not launch email app'),
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
    } on PlatformException catch (e) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('Unable to launch email app'),
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

  Future<void> launchCall() async {
    final Uri urlParsed = Uri.parse('tel: 2349087676578');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('Unable to make call'),
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

  Future<void> launchUrlSiteBrowser() async {
    final Uri urlParsed = Uri.parse("https://beauty-hub.onrender.com/");

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('Could not launch url'),
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

  Future<void> launchMap(String address) async {
    MapsLauncher.launchQuery(address);
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
          GestureDetector(
            onTap: () => launchUrlSiteBrowser(),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ref
                        .watch(displayProvider)
                        .colorScheme
                        .onInverseSurface
                        .withAlpha((0.8 * 255).toInt()),
                  ),
                  child: Icon(
                    Icons.language_outlined,
                    size: 30,
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LogaText(
                    content: "Website",
                    color: ref.watch(displayProvider).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => launchEmail(),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ref
                        .watch(displayProvider)
                        .colorScheme
                        .onInverseSurface
                        .withAlpha((0.8 * 255).toInt()),
                  ),
                  child: Image(
                    image: AssetImage('images/messages.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LogaText(
                    content: "Message",
                    color: ref.watch(displayProvider).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => launchCall(),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ref
                        .watch(displayProvider)
                        .colorScheme
                        .onInverseSurface
                        .withAlpha((0.8 * 255).toInt()),
                  ),
                  child: Image(
                    image: AssetImage('images/call.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LogaText(
                    content: "Call",
                    color: ref.watch(displayProvider).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => launchMap(widget.user.business_address),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ref
                        .watch(displayProvider)
                        .colorScheme
                        .onInverseSurface
                        .withAlpha((0.8 * 255).toInt()),
                  ),
                  child: Icon(
                    Icons.map_outlined,
                    size: 30,
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LogaText(
                    content: "Direction",
                    color: ref.watch(displayProvider).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                  ),
                )
              ],
            ),
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
                      color: ref
                          .watch(displayProvider)
                          .colorScheme
                          .onInverseSurface
                          .withAlpha((0.8 * 255).toInt()),
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
                          color: ref.watch(displayProvider).isLightMode
                              ? ref.watch(displayProvider).colorScheme.surface
                              : ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.displaySmall?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: ref.watch(displayProvider).isLightMode
                              ? ref.watch(displayProvider).colorScheme.surface
                              : ref.watch(displayProvider).colorScheme.outline,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LogaText(
                  content: "Cart",
                  color: selectedService.service != null && selectedService.service?.service_ref != null
                      ? ref.watch(displayProvider).colorScheme.onSurface
                      : ref.watch(displayProvider).colorScheme.outline,
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
