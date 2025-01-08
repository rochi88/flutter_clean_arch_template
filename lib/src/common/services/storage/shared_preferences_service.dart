// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService(this._sharedPreferences);

  final SharedPreferencesAsync _sharedPreferences;

  Future<void> clear() => _sharedPreferences.clear();

  Future<void> delete(String key) => _sharedPreferences.remove(key);

  Future<void> setBool(String key, bool value) =>
      _sharedPreferences.setBool(key, value);

  Future<void> setInt(String key, int value) =>
      _sharedPreferences.setInt(key, value);

  Future<void> setString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  Future<bool?> getBool(String key) => _sharedPreferences.getBool(key);

  Future<int?> getInt(String key) => _sharedPreferences.getInt(key);

  Future<String?> getString(String key) => _sharedPreferences.getString(key);
}
