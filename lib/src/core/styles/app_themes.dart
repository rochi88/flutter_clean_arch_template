import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightWhiteSmoke,
      appBarTheme: const AppBarTheme(
        color: AppColors.lightBg,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.darkBg,
    );
  }

  static CupertinoThemeData ilight() {
    return const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.lightPrimary,
        scaffoldBackgroundColor: AppColors.lightBg);
  }

  static CupertinoThemeData idark() {
    return const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.darkPrimary,
        scaffoldBackgroundColor: AppColors.darkBg);
  }
}
