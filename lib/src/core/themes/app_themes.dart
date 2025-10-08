// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'app_colors.dart';

class AppThemes {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightWhiteSmoke,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.lightBg),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        bodyMedium: const TextStyle(color: AppColors.lightBodyTextColor),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.darkBg,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkBg),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        bodyMedium: const TextStyle(color: AppColors.darkBodyTextColor),
      ),
    );
  }

  static CupertinoThemeData ilight() {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBg,
    );
  }

  static CupertinoThemeData idark() {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBg,
    );
  }
}
