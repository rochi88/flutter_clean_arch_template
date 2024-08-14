import '../models/app_state.dart';
import '../services/storage/secure_storage_service.dart';
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
