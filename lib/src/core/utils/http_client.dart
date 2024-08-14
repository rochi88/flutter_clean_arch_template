import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_clean_pro_temp/src/env.dart';
import '../../../main.dart';
import '../../../src/core/utils/http_interceptors/auth_interceptor.dart';
import '../../../src/core/utils/http_interceptors/error_interceptor.dart';
import '../../../src/core/utils/http_interceptors/user_agent_interceptor.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio_cache_interceptor_isar_store/dio_cache_interceptor_isar_store.dart';

class HttpClient with DioMixin implements Dio {
  HttpClient({BaseOptions? baseOptions}) {
    options = (baseOptions ?? BaseOptions()).copyWith(
      baseUrl: baseOptions?.baseUrl ?? Env.serverUrl,
      validateStatus: (int? status) {
        return status != null && status >= 200 && status < 400;
      },
    );
    interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(),
      UserAgentInterceptor(),
      DioFirebasePerformanceInterceptor(),
      DioCacheInterceptor(
        options: CacheOptions(
          maxStale: const Duration(hours: 12),
          store: IsarCacheStore(tempPath),
          policy: CachePolicy.request,
        ),
      ),
    ]);

    httpClientAdapter = NativeAdapter(
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            ..allowsCellularAccess = false
            ..allowsConstrainedNetworkAccess = false
            ..allowsExpensiveNetworkAccess = false,
    );

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }
}
