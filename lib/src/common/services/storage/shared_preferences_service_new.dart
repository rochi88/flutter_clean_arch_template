import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

class SharedPreferencesServicesNew implements StorageService {
  SharedPreferencesServicesNew(this._sharedPreferences);
  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<void> remove(String key) async => await _sharedPreferences.remove(key);

  @override
  Future<String?> get(String key) async =>
      await _sharedPreferences.getString(key);

  @override
  Future<void> set(String key, String data) async =>
      await _sharedPreferences.setString(key, data.toString());

  @override
  Future<void> clear() async => await _sharedPreferences.clear();

  @override
  Future<bool> has(String key) async =>
      await _sharedPreferences.containsKey(key) ? true : false;
}
