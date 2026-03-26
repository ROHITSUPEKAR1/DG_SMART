import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary blue
  static const Color primary = Color(0xFF3b9ef5);
  static const Color primaryDark = Color(0xFF2b7de8);
  static const Color primaryLight = Color(0xFFe8f4ff);

  // Success green
  static const Color success = Color(0xFF1a9e75);
  static const Color successLight = Color(0xFFC8EAC8);

  // Error red
  static const Color error = Color(0xFFc83a3a);
  static const Color errorLight = Color(0xFFF5C4C4);

  // Warning amber
  static const Color warning = Color(0xFFe8a020);
  static const Color warningLight = Color(0xFFF8E4A0);

  // Purple
  static const Color purple = Color(0xFF7b5edb);
  static const Color purpleLight = Color(0xFFD4C4EC);

  // Teacher gradient colors
  static const Color teacherPurple1 = Color(0xFF667eea);
  static const Color teacherPurple2 = Color(0xFF764ba2);
  static const Color teacherPink = Color(0xFFf093fb);
  static const Color teacherOrange = Color(0xFFf5a623);

  // Parent gradient colors
  static const Color parentPink1 = Color(0xFFf093fb);
  static const Color parentPink2 = Color(0xFFf5a623);
  static const Color parentPink3 = Color(0xFFf06292);
  static const Color parentRed = Color(0xFFe91e8c);
  static const Color parentAccent = Color(0xFFe91e63);

  // Student/App gradient
  static const Color gradBlue1 = Color(0xFF5BC8F5);
  static const Color gradBlue2 = Color(0xFF87D4F8);
  static const Color gradBlue3 = Color(0xFFB0E4FA);
  static const Color gradGreen = Color(0xFFC8EDD6);
  static const Color gradYellow = Color(0xFFF5E8B0);

  // Background & Surface
  static const Color background = Color(0xFFf4f7ff);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFe8eaf6);
  static const Color borderLight = Color(0xFFf0f2fa);

  // Text
  static const Color textPrimary = Color(0xFF1a1a2e);
  static const Color textMuted = Color(0xFF8899bb);
  static const Color textLight = Color(0xFFaab0cc);

  // Sidebar (admin)
  static const Color sidebarBg = Color(0xFF1a1a2e);
  static const Color sidebarText = Color(0xFFFFFFFF);

  // Blue chip colors
  static const Color chipBlueBg = Color(0xFFB8D4F0);
  static const Color chipBlueText = Color(0xFF0a3060);
  static const Color chipGreenBg = Color(0xFFC8EAC8);
  static const Color chipGreenText = Color(0xFF1a4d1a);
  static const Color chipRedBg = Color(0xFFF5C4C4);
  static const Color chipRedText = Color(0xFF5a1a1a);
  static const Color chipAmberBg = Color(0xFFF8E4A0);
  static const Color chipAmberText = Color(0xFF4a3000);
  static const Color chipPurpleBg = Color(0xFFD4C4EC);
  static const Color chipPurpleText = Color(0xFF2a0a5a);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.nunitoTextTheme().apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
