import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/screen/auth/forgot_password.dart';
import 'package:logaluxe_users/screen/auth/register.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/widget/button/icon_button.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';
import 'package:toastification/toastification.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  String passwordError = '';
  String emailError = '';
  String errorMessage = '';
  _login() async {
    try {
      var loginState = ref.read(loginProvider.notifier);
      loginState.enableLoading();
      String email = emailTextController.text.trim();
      String password = passwordTextController.text.trim();
      if (email.isEmpty || !email.contains("@") || (!email.contains('.ng') && !email.contains('.com')))
        setState(() {
          emailError = "Invalid email";
        });
      else if (password.isEmpty || password.length < 6)
        setState(() {
          emailError = "";
          passwordError = "Invalid password";
        });
      else
        setState(() {
          emailError = "";
          passwordError = "";
        });
      var loginRequest = await loginState.login(LoginRequest(email: email, password: password));
      ref.read(profileProvider.notifier).authenticate(loginRequest.data);
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(loginRequest.message),
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
      loginState.disableLoading();
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (ctx) => Home()), (Route<dynamic> route) => false);
    } catch (e) {
      ref.read(loginProvider.notifier).disableLoading();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back!",
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
              height: 100,
            ),
            LogaInputField(
              hintText: "Email",
              verticalPadding: 15,
              horizontalPadding: 35,
              setIconColor: false,
              alterVisibility: false,
              hideTextInput: false,
              prefixIconData: Icons.email,
              setIconSize: false,
              buttonBorder: 100,
              setIconPadding: false,
              prefixIcon: true,
              prefixImage: false,
              controller: emailTextController,
              errorText: emailError,
            ),
            const SizedBox(
              height: 20,
            ),
            LogaInputField(
              hintText: "********",
              verticalPadding: 15,
              horizontalPadding: 35,
              setIconColor: false,
              alterVisibility: true,
              hideTextInput: true,
              prefixIconData: Icons.lock,
              setIconSize: false,
              buttonBorder: 100,
              setIconPadding: false,
              prefixImage: false,
              prefixIcon: true,
              controller: passwordTextController,
              errorText: passwordError,
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
                    "Forget password?",
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                        color: Theme.of(context).colorScheme.onError),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: ref.watch(loginProvider).loading == true
                  ? null
                  : () {
                      _login();
                    },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(0, 0)),
                maximumSize: WidgetStateProperty.all(
                  Size(370, 50),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 3),
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Theme.of(context).colorScheme.onPrimary; // Custom disabled color
                    }
                    return Theme.of(context).colorScheme.onPrimary; // Custom disabled color
                  },
                ),
              ),
              child: ref.watch(loginProvider).loading == true
                  ? CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                    )
                  : Text(
                      "Login",
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Register();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
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
