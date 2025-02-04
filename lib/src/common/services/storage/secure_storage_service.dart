// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  Future<void> writeSecureData(String key, dynamic value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    return await _storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<Map> readAllSecureData() async {
    return await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<void> deleteSecureData(String key) async {
    await _storage.delete(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<void> deleteAllSecureData(String key) async {
    await _storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<void> replaceSecureData(String key, dynamic value) async {
    await _storage.delete(key: key);
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<void> writeSecureDataList(String key, List<String> value) async {
    await _storage.write(
        key: key,
        value: value.join(','),
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<List<String>> readSecureDataList(String key) async {
    final String? value = await _storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    return value!.split(',');
  }

  Future<bool> containsKeyInSecureData(String key) async {
    return await _storage.containsKey(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}
