import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logaluxe_users/screen/home.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFFEB4F87),
  background: const Color(0xFF000000),
  onPrimary: Color.fromARGB(255, 235, 76, 134),
  onSurface: const Color(0xFFFFFFFF),
  onSurfaceVariant: Color(0xff24262b),
  outline: Color.fromARGB(255, 89, 94, 107),
  onInverseSurface: Color.fromARGB(255, 40, 40, 40),
  onError: const Color(0xFFEB4F87),
  onTertiary: Color.fromARGB(255, 180, 178, 178),
  tertiaryContainer: Color(0xFF0F0704),
  onTertiaryContainer: Color.fromARGB(255, 106, 88, 83),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 14),
    titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
    titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 24),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      fixedSize: const Size(390, 60),
    ),
  ),
);
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LogaLuxe',
        theme: theme,
        //home: SplashScreen(),
        home: Home());
    //home: CustomBottomNavigationBar());
  }
}
