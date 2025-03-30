import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
  bool? isLightMode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLightMode = ref.read(displayProvider).isLightMode;
  }

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

  void _changeDisplay(bool value) {
    var display = ref.read(displayProvider.notifier).changeDisplayState(value);
    setState(() {
      isLightMode = display.isLightMode;
    });
    if (isLightMode == false) Phoenix.rebirth(context); //Re-start the application
  }

  @override
  Widget build(BuildContext context) {
    final _controller = ValueNotifier<bool>(isLightMode!);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogaText(
                content: "Display Mode",
                color: ref.watch(displayProvider).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
              ),
              AdvancedSwitch(
                controller: _controller,
                activeColor: ref.watch(displayProvider).colorScheme.onSurface,
                inactiveColor: ref.watch(displayProvider).colorScheme.onSurface,
                borderRadius: BorderRadius.all(const Radius.circular(15)),
                width: 60,
                height: 30,
                enabled: true,
                disabledOpacity: 0.5,
                initialValue: isLightMode!,
                onChanged: (value) {
                  _changeDisplay(value);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ref.watch(profileProvider).token == ''
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Login()));
                  },
                  child: LogaText(
                    content: "Log in",
                    color: ref.watch(displayProvider).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    logOut();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      LogaText(
                        content: "Log out",
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
