// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../models/app_state.dart';
import '../services/storage/secure_storage_service.dart';

part 'app_state_provider.g.dart';

@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    return AppState(
        token: SecureStorageService().readSecureData('token'),
        isDarkModeEnabled: false,
        isSynced: false,
        dbUpdatedAt: null);
  }

  void toggleTheme() {
    state = state.copyWith(isDarkModeEnabled: !state.isDarkModeEnabled);
  }

  void toggleSync() {
    state = state.copyWith(isSynced: !state.isSynced);
  }

  Future<void> setToken(String token) async {
    await SecureStorageService().writeSecureData('token', token);
    state = state.copyWith(token: Future.value(token));
  }

  Future<void> deleteToken() async {
    await SecureStorageService().deleteSecureData('token');
    state = state.copyWith(token: Future.value(null));
  }

  Future<void> setDbUpdatedAt(DateTime dbUpdatedAt) async {
    state = state.copyWith(dbUpdatedAt: dbUpdatedAt);
  }
}
