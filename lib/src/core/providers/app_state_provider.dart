// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../models/app_state.dart';
import 'package_info_provider.dart';
import 'shared_preferences_provider.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  SharedPreferencesWithCache get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;

  @override
  AppState build() {
    final themeModeStr = _sharedPreferences.getString('themeMode');
    final themeMode = switch (themeModeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' || _ => ThemeMode.system,
    };
    final appVersion = ref.watch(packageInfoProvider).value!.version;

    return AppState(
        themeMode: themeMode,
        onboardingCompleted:
            _sharedPreferences.getBool('onboardingCompleted') ?? false,
        languageCode: _sharedPreferences.getString('languageCode') ?? 'en',
        appVersion: appVersion,
        dbSynced: _sharedPreferences.getBool('dbSynced') ?? false,
        dbSyncedAt: _sharedPreferences.getString('dbSyncedAt') ?? '');
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    _sharedPreferences.setString('themeMode', state.themeMode.name);
    ref.invalidateSelf();
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(onboardingCompleted: true);
    _sharedPreferences.setBool('onboardingCompleted', true);
  }

  Future<void> setLanguageCode(String code) async {
    state = state.copyWith(languageCode: code);
    _sharedPreferences.setString('languageCode', state.languageCode);
  }

  void toggleSync() {
    state = state.copyWith(dbSynced: !state.dbSynced);
    _sharedPreferences.setBool('dbSynced', state.dbSynced);
  }

  Future<void> setDbSyncedAt(String? dbSyncedAt) async {
    state = state.copyWith(dbSyncedAt: dbSyncedAt);
    _sharedPreferences.setString('dbSyncedAt', state.dbSyncedAt!);
  }
}
