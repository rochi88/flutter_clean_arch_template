/// Storage service interface
abstract class StorageService {
  Future<void> remove(String key);

  Future<String?> get(String key);

  Future<void> set(String key, String data);

  Future<void> clear();

  Future<bool> has(String key);
}
