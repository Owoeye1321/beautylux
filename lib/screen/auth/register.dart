import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:logaluxe_users/provider/auth.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
    emailTextController.dispose();
    fistNameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          emailError = "Invalid email";
        });
      else if (password.isEmpty || password.length < 6)
        setState(() {
          passwordError = "Invalid passsword";
        });
      else
        try {
          setState(() {
            firstNameError = '';
            emailError = '';
            passwordError = '';
          });
          var register = await ref
              .read(registerProvider.notifier)
              .register(RegisterRequest(first_name: firstName, email: email, password: password));
          print(register);
        } catch (e) {
          String errorMessage = e.toString().replaceAll('Exception: ', '');
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            title: errorMessage,
            // type: ToastificationType.success,
            // style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
      register.disableLoading();
    }

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
              height: 20,
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
            LogaInputField(
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
              controller: fistNameTextController,
              errorText: firstNameError,
            ),
            const SizedBox(
              height: 20,
            ),
            LogaInputField(
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
              controller: emailTextController,
              errorText: emailError,
            ),
            const SizedBox(
              height: 20,
            ),
            LogaInputField(
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
              controller: passwordTextController,
              errorText: passwordError,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                _register();
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
              child: ref.watch(registerProvider).loading == true
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
