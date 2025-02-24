import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logaluxe_users/screen/auth/reset_password.dart';
import 'package:logaluxe_users/widget/input_field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Password,",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
                fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight!,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SplashText(
              title: "Please type in your email, we’ll send",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
            ),
            SplashText(
              title: "you a code to change your password.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
            ),
            const SizedBox(
              height: 100,
            ),
            const LogaInputField(
                hintText: "Email",
                buttonBorder: 100,
                verticalPadding: 20,
                horizontalPadding: 35,
                alterVisibility: false,
                hideTextInput: false,
                prefixIconData: Icons.email,
                setIconSize: false,
                prefixIcon: true,
                prefixImage: false,
                setIconColor: false,
                setIconPadding: false),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPassword();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Use phone number?",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 365,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ResetPassword();
                    },
                  ),
                );
              },
              child: Text(
                "Send Code",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
