import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logaluxe_users/screen/auth/reset_password.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailTextController = TextEditingController();
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
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SplashText(
              title: "Please type in your email, we’ll send",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            SplashText(
              title: "you a code to change your password.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
            ),
            const SizedBox(
              height: 70,
            ),
            LogaInputField(
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
              setIconPadding: false,
              controller: emailTextController,
            ),
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
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
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
                "Send Code",
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
