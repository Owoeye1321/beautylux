import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/auth/reset_password.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/screen/auth/password_otp.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';
import 'package:toastification/toastification.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  String passwordError = '';
  String confirmPasswordError = '';
  String errorMessage = '';

  _resetPaassword() async {
    try {
      var forgetPassword = ref.read(passwordResetProvider.notifier);
      var password = passwordTextController.text;
      var confirmPassword = confirmPasswordTextController.text;
      if (password.isEmpty || password.length < 7) {
        setState(() {
          passwordError = "Invalid password";
        });
      } else if (confirmPassword.isEmpty || confirmPassword != password) {
        setState(() {
          passwordError = '';
          confirmPasswordError = "Password do not match";
        });
      } else {
        forgetPassword.enableLoading();
        var response = await forgetPassword.changePassword(password);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          title: Text(response.message),
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
        forgetPassword.disableLoading();
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (ctx) => Login()), (Route<dynamic> route) => false);
      }
    } catch (e) {
      ref.read(passwordResetProvider.notifier).disableLoading();
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
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (ctx) => PasswordOTP()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loadingState = ref.watch(passwordResetProvider).loading;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 80,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 370,
                  child: LogaInputField(
                    onChange: (value) {},
                    hintText: "Password",
                    verticalPadding: 15,
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
                    errorText: passwordError,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 370,
                  child: LogaInputField(
                    onChange: (value) {},
                    hintText: "Confirm Password",
                    verticalPadding: 15,
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
                    errorText: confirmPasswordError,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 365,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: loadingState == true
                      ? null
                      : () {
                          _resetPaassword();
                        },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(0, 0)),
                    maximumSize: WidgetStateProperty.all(
                      Size(360, 50),
                    ),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 3),
                    ),
                  ),
                  child: loadingState == true
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                        )
                      : Text(
                          "Confirm New Password",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
