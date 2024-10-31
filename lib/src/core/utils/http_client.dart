// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';
import 'http_interceptors/user_agent_interceptor.dart';

import 'package:native_dio_adapter/native_dio_adapter.dart'; // !!!! DO NOT USE THIS ON WEB BUILD !!!!


class HttpClient with DioMixin implements Dio {
  HttpClient({BaseOptions? baseOptions}) {
    options = (baseOptions ?? BaseOptions()).copyWith(
      validateStatus: (int? status) {
        return status != null && status >= 200 && status < 400;
      },
    );

    // !!!! DO NOT USE THIS ON WEB BUILD !!!!
    httpClientAdapter = NativeAdapter(
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            ..allowsCellularAccess = false
            ..allowsConstrainedNetworkAccess = false
            ..allowsExpensiveNetworkAccess = false,
    );

    interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(),
      UserAgentInterceptor(),
      DioFirebasePerformanceInterceptor(),
    ]);

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
