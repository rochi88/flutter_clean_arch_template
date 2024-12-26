// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../common/providers/http_client_provider.dart';
import '../../data/auth_repository.dart';
import '../../domain/models/app_user.dart';

part 'auth_controller_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authController(Ref ref) {
  final httpClient = ref.read(httpClientProvider);
  final auth = AuthRepository(httpClient: httpClient);
  ref.onDispose(() => auth.dispose());
  return auth;
}

@riverpod
Future<AppUser?> getUser(Ref ref) {
  return ref.watch(authControllerProvider).getUser();
}
