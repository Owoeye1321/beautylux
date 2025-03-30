import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/appointment.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/auth/verify_email.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/screen/pages/history.dart';
import 'package:logaluxe_users/screen/pages/market_place.dart';
import 'package:logaluxe_users/screen/pages/search.dart';
import 'package:logaluxe_users/screen/pages/settings.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/nav_bar.dart';
import 'package:toastification/toastification.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentIndex = 0;
  int? prevIndex;
  String activeView = 'grid';
  String errorMessage = '';

  _switchContent(int activeIndex, previousIndex) {
    setState(() {
      currentIndex = activeIndex;
      prevIndex = previousIndex;
    });
    if (currentIndex == 2) {
      var loggedInUser = ref.read(profileProvider);
      if (loggedInUser.token == '')
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
      else
        try {
          String token =
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2ExZTI2M2NlZWRlYWRkMWJhMjYyZTQiLCJuYW1lIjoiam9zaG5qb2huIiwicm9sZSI6InByb2Zlc3Npb25hbCIsImlhdCI6MTc0MzI4MDAyNCwiZXhwIjoxNzQzMzY2NDI0fQ.2ms8GCm7mq1QUoYi7Ef8uL7Ckax9pUY1zMelkkP_irQ';
          ref.read(appointmentProvider.notifier).fetchAppointment(loggedInUser.token, loggedInUser.id);
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
  }

  @override
  Widget build(BuildContext context) {
    _bookNow() {
      print('hwllo');
      _switchContent(0, 1);
      print(currentIndex);
    }

    String username = ref.watch(profileProvider).first_name;
    if (username == '') {
      username = 'Jack EL';
    } else {
      username = username;
    }

    return Scaffold(
      appBar: currentIndex == 0
          ? AppBar(
              toolbarHeight: 90,
              leadingWidth: 70,
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: ClipOval(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        image: const DecorationImage(
                          image: AssetImage('images/dp.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: 150,
                      child: LogaText(
                          content: "Hey, ${username} 👋 ",
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight),
                    )
                  ],
                ),
                const SizedBox(
                  width: 100,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.notifications_none_sharp,
                        size: 30,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          : currentIndex == 1
              ? AppBar(
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Search ",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 155,
                    ),
                  ],
                )
              : currentIndex == 2
                  ? AppBar(
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 160),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "History",
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
                                  fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : AppBar(
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Settings ",
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
                                  fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                      ],
                    ),
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: BottomBar(
        width: 370,
        barColor: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha((0.6 * 255).toInt()),
        fit: StackFit.expand,
        borderRadius: BorderRadius.circular(15),
        duration: Duration(seconds: 1),
        curve: Curves.decelerate,
        offset: 0,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 35,
        iconWidth: 35,
        reverse: false,
        hideOnScroll: false, // ✅ Ensure bar stays visible
        scrollOpposite: false,
        child: CustomBottomNavigationBar(
          activeIndex: currentIndex,
          currentIndex: currentIndex,
          getActiveIndex: _switchContent,
        ),
        body: (context, controller) => SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: currentIndex == 0
                ? MarketPlace(
                    key: ValueKey(0),
                    bookNow: () {
                      _bookNow();
                    })
                : currentIndex == 1
                    ? Search(
                        key: ValueKey(1),
                      )
                    : currentIndex == 2
                        ? BookingHistory(
                            key: ValueKey(2),
                          )
                        : Settings(
                            key: ValueKey(3),
                          ),
          ),
        ),
      ),
    );
  }
}
