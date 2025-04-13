import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/auth/register.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/screen/auth/verify_email.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/third-party/gmail_sso.dart';
import 'package:logaluxe_users/widget/button/icon_button.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';
import 'package:toastification/toastification.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  var emailTextController = TextEditingController();
  var fistNameTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  String firstNameError = '';
  String emailError = '';
  String passwordError = '';
  bool gmailLoadingState = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailTextController.dispose();
    fistNameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  _register() async {
    var register = ref.read(registerProvider.notifier);
    register.enableLoading();
    String email = emailTextController.text.trim();
    String password = passwordTextController.text.trim();
    String firstName = fistNameTextController.text.trim();
    if (firstName.isEmpty)
      setState(() {
        firstNameError = "Invalid first name";
      });
    else if (email.isEmpty || !email.contains("@") || (!email.contains('.ng') && !email.contains('.com')))
      setState(() {
        firstNameError = '';
        emailError = "Invalid email";
      });
    else if (password.isEmpty || password.length < 6)
      setState(() {
        emailError = '';
        passwordError = "Invalid passsword";
      });
    else
      try {
        setState(() {
          firstNameError = '';
          emailError = '';
          passwordError = '';
        });
        var initiateRegisteration = await ref
            .read(registerProvider.notifier)
            .register(RegisterRequest(first_name: firstName, email: email, password: password));
        register.disableLoading();
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          title: Text(initiateRegisteration.message),
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          autoCloseDuration: const Duration(seconds: 6),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => VerifyEmail(),
          ),
        );
      } catch (e) {
        register.disableLoading();
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          title: Text(errorMessage),
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          autoCloseDuration: const Duration(seconds: 3),
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

  _loginWithGoogle() async {
    try {
      setState(() {
        gmailLoadingState = true;
      });
      UserModel? user = await UserRepository.loginWithGoodgle();
      if (user != null && mounted) {
        var loginRequest =
            await ref.read(loginProvider.notifier).gmail_sso(user.email!, user.first_name, user.image_url);
        ref.read(profileProvider.notifier).authenticate(loginRequest.data);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          title: Text("Login successful"),
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
        setState(() {
          gmailLoadingState = false;
        });
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (ctx) => Home()), (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(e.toString()),
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
      setState(() {
        gmailLoadingState = false;
      });
    } catch (e) {
      print(e.toString());
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('Unable to login with Google'),
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
      setState(() {
        gmailLoadingState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loadingState = ref.watch(registerProvider).loading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(top: 80, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
              height: 15,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Platform.isIOS ? 370 : 360,
                  child: LogaInputField(
                    onChange: (value) {},
                    hintText: "First Name",
                    verticalPadding: 15,
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
                    controller: fistNameTextController,
                    errorText: firstNameError,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Platform.isIOS ? 370 : 360,
                  child: LogaInputField(
                    onChange: (value) {},
                    hintText: "Email",
                    verticalPadding: 15,
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
                    controller: emailTextController,
                    errorText: emailError,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Platform.isIOS ? 370 : 360,
                  child: LogaInputField(
                    onChange: (value) {},
                    hintText: "********",
                    setIconColor: false,
                    verticalPadding: 15,
                    horizontalPadding: 35,
                    alterVisibility: true,
                    hideTextInput: true,
                    buttonBorder: 100,
                    setIconSize: false,
                    prefixIconData: Icons.lock,
                    setIconPadding: false,
                    prefixIcon: true,
                    prefixImage: false,
                    controller: passwordTextController,
                    errorText: passwordError,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: loadingState == true
                      ? null
                      : () {
                          _register();
                        },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(0, 0)),
                    maximumSize: WidgetStateProperty.all(
                      Size(360, 50),
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
                  child: loadingState == true
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                        )
                      : Text(
                          "Signup",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                ),
              ],
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
            gmailLoadingState == false
                ? LogaIconButton(
                    trailingType: "image",
                    text: 'Continue with Google',
                    image: AssetImage('images/google.png'),
                    icon: Icons.apple,
                    onPressed: () async {
                      _loginWithGoogle();
                    },
                  )
                : Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                      ),
                    ),
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
