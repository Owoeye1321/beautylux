import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
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
              "New Password,",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SplashText(
              title: "Now, you can create your password",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            SplashText(
              title: "and confim it below.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            const SizedBox(
              height: 70,
            ),
            LogaInputField(
              hintText: "Password",
              verticalPadding: 20,
              horizontalPadding: 35,
              setIconSize: false,
              alterVisibility: true,
              hideTextInput: true,
              buttonBorder: 100,
              setIconColor: false,
              prefixIconData: Icons.lock,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
              controller: passwordTextController,
              errorText: '',
            ),
            const SizedBox(
              height: 15,
            ),
            LogaInputField(
              hintText: "Confirm Password",
              verticalPadding: 20,
              horizontalPadding: 35,
              alterVisibility: true,
              setIconColor: false,
              buttonBorder: 100,
              hideTextInput: true,
              setIconSize: false,
              prefixIconData: Icons.lock,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
              controller: confirmPasswordTextController,
              errorText: '',
            ),
            const SizedBox(
              height: 365,
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
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(0, 0)),
                maximumSize: MaterialStateProperty.all(
                  Size(370, 50),
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 3),
                ),
              ),
              child: Text(
                "Confirm New Password",
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
