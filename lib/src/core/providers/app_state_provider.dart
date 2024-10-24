// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../models/app_state.dart';
import 'shared_preferences_provider.dart';

part 'app_state_provider.g.dart';

@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  SharedPreferences get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;

  @override
  AppState build() {
    return AppState(
        dbSynced: _sharedPreferences.getBool('dbSynced')!,
        dbSyncedAt: _sharedPreferences.getString('dbSyncedAt')!);
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
