import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central brand palette for Alert 247.
class AppColors {
  AppColors._();

  static const Color emergencyRed = Color(0xFFFF0000);
  static const Color darkNavy = Color(0xFF050B1F);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color successGreen = Color(0xFF22C55E);
  static const Color warningOrange = Color(0xFFF97316);

  // Supporting shades used across glass cards / surfaces.
  static const Color surface = Color(0xFF0B1530);
  static const Color surfaceElevated = Color(0xFF101B3B);
  static const Color textMuted = Color(0xFF8C93A8);
  static const Color divider = Color(0x1FFFFFFF);

  static const LinearGradient navyGlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0B1230), darkNavy, Color(0xFF02040D)],
  );

  static RadialGradient redPulse({double opacity = 0.35}) => RadialGradient(
        colors: [
          emergencyRed.withOpacity(opacity),
          emergencyRed.withOpacity(0.0),
        ],
      );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.interTightTextTheme(base.textTheme).apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.darkNavy,
      textTheme: textTheme,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.emergencyRed,
        secondary: AppColors.warningOrange,
        surface: AppColors.surface,
        error: AppColors.emergencyRed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      dividerColor: AppColors.divider,
      splashFactory: InkRipple.splashFactory,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.emergencyRed,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.emergencyRed,
        unselectedItemColor: AppColors.textMuted,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
