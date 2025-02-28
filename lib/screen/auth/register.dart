import 'package:flutter/material.dart';
import 'package:logaluxe_users/screen/auth/verify_email.dart';
import 'package:logaluxe_users/widget/button/icon_button.dart';
import 'package:logaluxe_users/widget/input_field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              "Create an account,",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SplashText(
              title: "Find and book Beauty, salon, Barber",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            const SizedBox(
              height: 3,
            ),
            SplashText(
              title: "and Spa services anywhere, anytime.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            const SizedBox(
              height: 70,
            ),
            const LogaInputField(
              hintText: "First Name",
              verticalPadding: 20,
              horizontalPadding: 35,
              alterVisibility: false,
              setIconColor: false,
              hideTextInput: false,
              prefixIconData: Icons.person,
              setIconSize: false,
              buttonBorder: 100,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const LogaInputField(
              hintText: "Email",
              verticalPadding: 20,
              setIconSize: false,
              horizontalPadding: 35,
              alterVisibility: false,
              buttonBorder: 100,
              hideTextInput: false,
              setIconColor: false,
              prefixIconData: Icons.email,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const LogaInputField(
              hintText: "********",
              setIconColor: false,
              verticalPadding: 20,
              horizontalPadding: 35,
              alterVisibility: true,
              hideTextInput: true,
              buttonBorder: 100,
              setIconSize: false,
              prefixIconData: Icons.lock,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return VerifyEmail();
                    },
                  ),
                );
              },
              child: Text(
                "Signup",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.onInverseSurface, // Line color
                    thickness: 1, // Line thickness
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8), // Space around text
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const LogaIconButton(
              trailingType: "image",
              text: 'Continue with Google',
              image: AssetImage('images/google.png'),
              icon: Icons.apple,
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
