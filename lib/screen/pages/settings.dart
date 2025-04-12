import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/third-party/gmail_sso.dart';
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
    UserRepository().signOut();
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
          LogaText(
            content: "Preference",
            color: ref.watch(displayProvider).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: ref.watch(displayProvider).colorScheme.onSurface.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      LogaText(
                        content: "Display Mode",
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                    ],
                  ),
                  AdvancedSwitch(
                    controller: _controller,
                    activeColor: Colors.white,
                    inactiveColor: Colors.black,
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
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: ref.watch(displayProvider).colorScheme.onSurface.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(20)),
            child: ref.watch(profileProvider).token == ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Login()));
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
                            content: "Log in",
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                            fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  ),
          ),
        ],
      ),
    );
  }
}
