import 'package:flutter_clean_pro_temp/src/core/models/app_state.dart';
import 'package:flutter_clean_pro_temp/src/core/services/storage/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    return AppState(
        token: SecureStorageService().readSecureData('token'),
        isDarkModeEnabled: false,
        isSynced: false,
        dbVersion: '0.0.1');
  }

  void toggleTheme() {
    state = state.copyWith(isDarkModeEnabled: !state.isDarkModeEnabled);
  }
}
