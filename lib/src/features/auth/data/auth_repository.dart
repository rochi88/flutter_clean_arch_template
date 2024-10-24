// Project imports:
import '../../../core/helpers/app_helpers.dart';
import '../../../core/helpers/delay.dart';
import '../../../core/services/storage/secure_storage_service.dart';
import '../../../core/utils/http_client.dart';
import '../../../core/utils/in_memory_store.dart';
import '../domain/models/app_user.dart';

class AuthRepository {
  AuthRepository({required this.httpClient, this.addDelay = false});
  final bool addDelay;
  final HttpClient httpClient;
  final secureStorageService = SecureStorageService();
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  void dispose() => _authState.close();

  Future<void> signIn(String phone, String password) async {
    await delay(addDelay);

    String? fcmToken = await getFcmToken();

    final response = await httpClient.post('/auth/login', data: {
      'phone': phone,
      'password': password,
      'device_name': 'userapp',
      'fcm_token': fcmToken
    });

    if (response.data != null) {
      _authState.value = AppUser.fromJson(response.data!['user']);
      secureStorageService.replaceSecureData('token', response.data['token']);
    }
  }

  Future<void> signOut() async {
    await secureStorageService.deleteSecureData('token');
    _authState.value = null;
  }

  Future<void> getUser() {
    return httpClient.get('/auth/user').then((response) {
      _authState.value = AppUser.fromJson(response.data!['user']);
    });
  }
}
