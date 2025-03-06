import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logaluxe_users/screen/home.dart';
import 'package:logaluxe_users/screen/splash.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFFEB4F87),
  background: const Color(0xFF000000),
  onPrimary: Color.fromARGB(255, 235, 76, 134),
  onSurface: const Color(0xFFFFFFFF),
  onSurfaceVariant: Color(0xff24262b),
  outline: Color(0xFF9CA3AF),
  onInverseSurface: Color(0xFF252525),
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
    displaySmall: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 8),
    bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 12),
    bodyMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15),
    bodyLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 20),
    titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 16),
    titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 24),
    titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 28),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      minimumSize: Size(0, 0),
      fixedSize: const Size(380, 60),
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
      home: Home(),
    );
  }
}
