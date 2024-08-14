import '../../data/auth_ripository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState.initial;
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading;
    try {
      state = await AuthRepository().login(email, password);
    } catch (e) {
      state = AuthState.error;
    }
  }

  Future<void> logout() async {
    state = AuthState.loading;
    try {
      state = AuthState.initial;
    } catch (e) {
      state = AuthState.error;
    }
  }
}
