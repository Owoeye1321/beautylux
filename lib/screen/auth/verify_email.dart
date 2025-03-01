import 'package:flutter/material.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/input-field/otp.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String timer = "00:00";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 80,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email Verification,",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SplashText(
              title: "Please type OTP code that was sent to",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            SplashText(
              title: " your mail.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            const SizedBox(
              height: 80,
            ),
            const OTP(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Resend on",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      timer,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 380,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                );
              },
              child: Text(
                "Verify Email",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
