import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:toastification/toastification.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  logOut() async {
    ref.read(profileProvider.notifier).logOut();
    await toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text("Logged out"),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 100),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (ctx) => Login()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    bool isLightMode = ref.watch(displayProvider).isLightMode;
    final _controller = ValueNotifier<bool>(isLightMode);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogaText(
                content: "Display Mode",
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
              ),
              AdvancedSwitch(
                controller: _controller,
                activeColor: Theme.of(context).colorScheme.onSurface,
                inactiveColor: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.all(const Radius.circular(15)),
                width: 80,
                height: 40.0,
                enabled: true,
                disabledOpacity: 0.5,
                onChanged: (value) {
                  ref.read(displayProvider.notifier).changeDisplayState(value);
                },
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              logOut();
            },
            child: Row(
              children: [
                LogaText(
                  content: "Log out",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
