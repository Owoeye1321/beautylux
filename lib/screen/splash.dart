import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/button/icon_button.dart';
import 'package:logaluxe_users/widget/splash/splash_content.dart';

import 'auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentSplash = 0;
  void _updateContent() => {
        setState(
          () {
            currentSplash += 1;
          },
        )
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.background,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  currentSplash <= 2 ? const SizedBox(height: 490) : const SizedBox(height: 450),
                  Container(
                    height: currentSplash <= 2 ? 155 : 130,
                    child: SplashContent(currentSplash: currentSplash),
                  ),
                  currentSplash <= 2
                      ? ElevatedButton(
                          onPressed: _updateContent,
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              Size(0, 0),
                            ),
                            fixedSize: MaterialStateProperty.all((Size(350, 55))),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Theme.of(context).colorScheme.onSurface),
                          ),
                        )
                      : Column(
                          children: const [
                            LogaIconButton(
                              trailingType: "icon",
                              text: "Continue with Apple",
                              image: AssetImage(''),
                              icon: Icons.apple,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LogaIconButton(
                              trailingType: "image",
                              text: 'Continue with Google',
                              image: AssetImage('images/google.png'),
                              icon: Icons.apple,
                            ),
                          ],
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
                                return const Login();
                              },
                            ),
                          );
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
            )
          ]),
        ),
      ),
    );
  }
}
