// Flutter imports:
import 'package:flutter/material.dart';

class AppState {
  ThemeMode themeMode;
  Future<String?>? jwtToken;
  bool onboardingCompleted;
  String languageCode;
  String? appVersion;
  bool dbSynced;
  String? dbSyncedAt;

  AppState({
    this.themeMode = ThemeMode.light,
    this.jwtToken,
    this.onboardingCompleted = false,
    this.languageCode = 'en',
    this.appVersion,
    this.dbSynced = false,
    this.dbSyncedAt,
  });

  AppState copyWith({
    ThemeMode? themeMode,
    Future<String>? jwtToken,
    bool? onboardingCompleted,
    String? languageCode,
    String? appVersion,
    bool? dbSynced,
    String? dbSyncedAt,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      jwtToken: jwtToken ?? this.jwtToken,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      languageCode: languageCode ?? this.languageCode,
      appVersion: appVersion ?? this.appVersion,
      dbSynced: dbSynced ?? this.dbSynced,
      dbSyncedAt: dbSyncedAt ?? this.dbSyncedAt,
    );
  }
}
