import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logaluxe_users/firebase_options.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/screen/auth/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    print('Error loading .env file: $e'); // Print error if any
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) {
      runApp(
        Phoenix(
          child: const ProviderScope(
            child: MyApp(),
          ),
        ),
      );
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var colorScheme = ref.watch(displayProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogaLuxe',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: colorScheme.colorScheme.surface,
        colorScheme: colorScheme.colorScheme,
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
            backgroundColor: colorScheme.colorScheme.onPrimary,
            //padding: const EdgeInsets.symmetric(horizontal: 20),
            minimumSize: Size(0, 0),
            fixedSize: Size(screenWidth * 0.88, 50),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
