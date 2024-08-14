import 'dart:io';

import 'package:dio/dio.dart';
import '../../services/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO(You): Put the paths you want the interceptor to ignore
    if (!options.path.contains('/login')) {
      // TODO(You): Fetch your access token and plug it in
      Future<String?> token = SecureStorageService().readSecureData('token');
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }
}
