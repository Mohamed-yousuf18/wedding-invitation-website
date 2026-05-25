// ============================================================
// app/theme/app_theme.dart
// Central theme file — all colors, fonts, styles in one place.
//
// HOW TO USE IN WIDGETS:
//   Color gold = AppColors.gold;
//   TextStyle name = AppTextStyles.coupleNames;
//   Theme.of(context).textTheme.headlineLarge
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── COLOR PALETTE ─────────────────────────────────────────
class AppColors {
  AppColors._();

  // Gold shades
  static const Color gold        = Color(0xFFC9A84C);
  static const Color goldLight   = Color(0xFFE8CC7A);
  static const Color goldDark    = Color(0xFF8B6914);
  static const Color goldGlow    = Color(0x33C9A84C); // gold with 20% opacity

  // Rose / Pink shades
  static const Color rose        = Color(0xFFF2B5C4);
  static const Color roseDeep    = Color(0xFFC4627A);
  static const Color rosePale    = Color(0xFFFDF0F4);

  // Background shades (dark romantic)
  static const Color bgDark      = Color(0xFF0D0407);
  static const Color bgMid       = Color(0xFF1A0810);
  static const Color bgCard      = Color(0xFF2D1020);

  // Text shades
  static const Color textLight   = Color(0xFFFDF8F0); // cream white
  static const Color textMuted   = Color(0xFFA08070);
  static const Color textGold    = Color(0xFFC9A84C);

  // Gradient presets
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF3D1525), Color(0xFF1A0A05), Color(0xFF0D0407)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldDark, gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x15FFFFFF), Color(0x05FFFFFF)],
  );
}

// ── TEXT STYLES ───────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // Couple names — big serif font
  static TextStyle coupleNames = GoogleFonts.cormorantGaramond(
    fontSize: 52,
    fontWeight: FontWeight.w300,
    color: AppColors.textLight,
    height: 1.1,
    letterSpacing: 1.0,
  );

  // Section titles
  static TextStyle sectionTitle = GoogleFonts.cormorantGaramond(
    fontSize: 36,
    fontWeight: FontWeight.w300,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );

  // Small caps labels (BRIDE, EVENT DATE, etc.)
  static TextStyle label = GoogleFonts.cinzel(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.gold,
    letterSpacing: 3.0,
  );

  // Body / description text
  static TextStyle body = GoogleFonts.cormorantGaramond(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.rose,
    height: 1.8,
    fontStyle: FontStyle.italic,
  );

  // Button text
  static TextStyle button = GoogleFonts.cinzel(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.5,
    color: AppColors.bgDark,
  );

  // Countdown numbers
  static TextStyle countdownNum = GoogleFonts.cinzel(
    fontSize: 38,
    fontWeight: FontWeight.w400,
    color: AppColors.goldLight,
  );

  // Countdown labels
  static TextStyle countdownLabel = GoogleFonts.lato(
    fontSize: 9,
    letterSpacing: 2.5,
    color: AppColors.textMuted,
  );
}

// ── MAIN THEME ────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      // Use Material 3 design system
      useMaterial3: true,

      // Scaffold (page background) color
      scaffoldBackgroundColor: AppColors.bgDark,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.rose,
        surface: AppColors.bgMid,
        onPrimary: AppColors.bgDark,
        onSurface: AppColors.textLight,
      ),

      // Text theme using Google Fonts
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 52, fontWeight: FontWeight.w300, color: AppColors.textLight,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 32, color: AppColors.textLight,
        ),
        bodyLarge: GoogleFonts.lato(fontSize: 16, color: AppColors.textLight),
        bodyMedium: GoogleFonts.lato(fontSize: 14, color: AppColors.textMuted),
        labelSmall: GoogleFonts.cinzel(
          fontSize: 10, letterSpacing: 2.5, color: AppColors.gold,
        ),
      ),

      // App bar styling
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.gold),
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 14,
          letterSpacing: 3,
          color: AppColors.goldLight,
        ),
      ),

      // Input field styling for RSVP form
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x0DFFFFFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.goldGlow),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gold.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
        hintStyle: GoogleFonts.lato(color: AppColors.textMuted, fontSize: 14),
        labelStyle: GoogleFonts.cinzel(
          color: AppColors.gold, fontSize: 10, letterSpacing: 2,
        ),
      ),

      // Elevated button styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.bgDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          textStyle: GoogleFonts.cinzel(fontSize: 12, letterSpacing: 2.5),
          elevation: 0,
        ),
      ),
    );
  }
}