import '../domain/auth_state.dart';

abstract class AuthRepositoryInterface {
  Future<AuthState> login(String phone, String password);

  Future<AuthState> signUp(String name, String phone, String password);
}
