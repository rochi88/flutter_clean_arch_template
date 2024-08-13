import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

enum AuthenticationState { initial, loading, success, error }

@riverpod
class Authentication extends _$Authentication {
  @override
  AuthenticationState build() {
    return AuthenticationState.initial;
  }

  Future<void> login() async {
    state = AuthenticationState.loading;
    try {
      await Future.delayed(const Duration(seconds: 2));
      state = AuthenticationState.success;
    } catch (e) {
      state = AuthenticationState.error;
    }
  }
}
