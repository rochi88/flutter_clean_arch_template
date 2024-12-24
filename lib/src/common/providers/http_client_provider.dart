// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../env.dart';
import '../utils/http_client.dart';
import 'package_info_provider.dart';

part 'http_client_provider.g.dart';

@Riverpod(keepAlive: true)
HttpClient httpClient(Ref ref) {
  return HttpClient(
    baseOptions: BaseOptions(baseUrl: '${Env.serverUrl}/${Env.apiVersion}'),
    packageInfo: ref.watch(packageInfoProvider).value,
  );
}
