import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:logaluxe_users/provider/auth/register.dart';
import 'package:logaluxe_users/provider/auth/verify_email.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/input-field/otp.dart';
import 'package:logaluxe_users/widget/splash/text.dart';
import 'package:toastification/toastification.dart'
    show ToastificationStyle, ToastificationType, toastification;

class VerifyEmail extends ConsumerStatefulWidget {
  const VerifyEmail({super.key});

  @override
  ConsumerState<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends ConsumerState<VerifyEmail> {
  String errorMessage = '';
  String enteredOtp = '';
  @override
  void initState() {
    super.initState();

    // Delay the dialog to ensure the screen is fully loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    var register = ref.watch(registerProvider);
    if (register.code == 200) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(register.message),
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
    }
  }

  _resubmit() async {
    print(enteredOtp);
    await _submitOtp(enteredOtp);
  }

  _submitOtp(String verificationCode) async {
    var verifyEmailRequest = ref.read(verifyEmailProvider.notifier);
    setState(() {
      enteredOtp = verificationCode;
    });
    verifyEmailRequest.enableLoading();
    try {
      await verifyEmailRequest.verifyOtp(
        VerifyEmailRequest(email: ref.watch(registerProvider).email!, otp: verificationCode),
      );
      verifyEmailRequest.disableLoading();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => Home(),
        ),
      );
    } catch (e) {
      verifyEmailRequest.disableLoading();
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
    var loadingState = ref.watch(verifyEmailProvider).loading;
    String timer = "00:00";
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
            OTP(
              onsubmit: _submitOtp,
            ),
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
              height: 360,
            ),
            ElevatedButton(
              onPressed: loadingState == true
                  ? null
                  : () {
                      _resubmit;
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
              child: loadingState == true
                  ? CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                    )
                  : Text(
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
