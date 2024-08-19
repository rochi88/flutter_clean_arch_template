import '../../../core/utils/http_client.dart';

import 'auth_ripository_interface.dart';
import '../domain/enums/auth_state.dart';

class AuthRepository implements AuthRepositoryInterface {
  @override
  Future<AuthState> login(String phone, String password) {
    HttpClient().post('/login', data: {'phone': phone, 'password': password});
    return Future.value(AuthState.success);
  }

  @override
  Future<AuthState> signUp(String name, String phone, String password) {
    HttpClient().post('/signup',
        data: {'name': name, 'phone': phone, 'password': password});
    return Future.value(AuthState.success);
  }
}
