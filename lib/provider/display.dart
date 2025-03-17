import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/display.dart';

class DisplayNotifier extends StateNotifier<DisplayState> {
  DisplayNotifier()
      : super(DisplayState(
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: const Color(0xFFEB4F87),
              surface: const Color(0xFF000000),
              onPrimary: Color.fromARGB(255, 235, 76, 134),
              onSurface: const Color(0xFFFFFFFF),
              onSurfaceVariant: Color(0xff24262b),
              outline: Color(0xFF9CA3AF),
              onInverseSurface: Color(0xFF252525),
              onError: const Color(0xFFEB4F87),
              onTertiary: Color.fromARGB(255, 180, 178, 178),
              tertiaryContainer: Color(0xFF0F0704),
              onTertiaryContainer: Color.fromARGB(255, 85, 68, 63),
            ),
            isLightMode: false));
  changeDisplayState(bool isLightMode) {
    if (isLightMode == true) {
      state = DisplayState(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: const Color(0xFFEB4F87), // Keep the same seed color for consistency
            surface: const Color(0xFFFFFFFF), // White surface
            onPrimary: Color.fromARGB(255, 235, 76, 134),
            onSurface: const Color(0xFF000000), // Black text/icons on light surfaces
            onSurfaceVariant: Color(0xff24262b),
            primary: Color.fromARGB(255, 235, 76, 134),
            outline: Color(0xFF6B7280), // Slightly darker outline for visibility
            onInverseSurface: Color(0xFF252525),
            onError: const Color(0xFFD32F2F), // Standard error color (red)
            onTertiary: Color.fromARGB(255, 180, 178, 178),
            tertiaryContainer: Color(0xFFFDF3F2), // Light pinkish surface for tertiary
            onTertiaryContainer: Color.fromARGB(255, 52, 51, 51), // Darker text/icons for contrast
          ),
          isLightMode: isLightMode);
    } else {
      state = DisplayState(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: const Color(0xFFEB4F87),
            surface: const Color(0xFF000000),
            onPrimary: Color.fromARGB(255, 235, 76, 134),
            onSurface: const Color(0xFFFFFFFF),
            onSurfaceVariant: Color(0xff24262b),
            outline: Color(0xFF9CA3AF),
            onInverseSurface: Color(0xFF252525),
            onError: const Color(0xFFEB4F87),
            onTertiary: Color.fromARGB(255, 180, 178, 178),
            tertiaryContainer: Color(0xFF0F0704),
            onTertiaryContainer: Color.fromARGB(255, 85, 68, 63),
          ),
          isLightMode: false);
    }
  }
}

var displayProvider = StateNotifierProvider<DisplayNotifier, DisplayState>((ref) => DisplayNotifier());
