import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/auth/reset_password.dart';
import 'package:logaluxe_users/screen/auth/password_otp.dart';
import 'package:logaluxe_users/screen/auth/reset_password.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/splash/text.dart';
import 'package:toastification/toastification.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  var emailTextController = TextEditingController();
  String emailError = '';
  String errorMessage = '';
  _forgetPassword() async {
    try {
      var forgetPassword = ref.read(passwordResetProvider.notifier);
      var email = emailTextController.text.trim();
      if (email.isEmpty || !email.contains("@") || (!email.contains('.ng') && !email.contains('.com'))) {
        setState(() {
          emailError = "Invalid email";
        });
      } else {
        forgetPassword.enableLoading();
        var response = await forgetPassword.resetPassword(email);
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
            context, MaterialPageRoute(builder: (ctx) => PasswordOTP()), (Route<dynamic> route) => false);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loadingState = ref.watch(passwordResetProvider).loading;
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
              onChange: (value) {},
              hintText: "Email",
              buttonBorder: 100,
              verticalPadding: 15,
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
              errorText: emailError,
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
              onPressed: loadingState == true
                  ? null
                  : () {
                      _forgetPassword();
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
                      return Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withAlpha((0.5 * 255).toInt()); // Custom disabled color
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
