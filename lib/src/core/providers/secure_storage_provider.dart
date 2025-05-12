// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../services/storage/secure_storage_service_new.dart';

part 'secure_storage_provider.g.dart';

@riverpod
Future<SecureStorageServiceNew> secureStorage(Ref ref) =>
    SecureStorageServiceNew.getInstance(keys: {'token'});
