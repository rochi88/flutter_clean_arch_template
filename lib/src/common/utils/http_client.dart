// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:dio_web_adapter/dio_web_adapter.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';
import 'http_interceptors/user_agent_interceptor.dart';
import 'target_platform.dart';

// import 'package:native_dio_adapter/native_dio_adapter.dart'; // !!!! DO NOT USE THIS ON WEB BUILD !!!!

class HttpClient with DioMixin implements Dio {
  HttpClient({BaseOptions? baseOptions, PackageInfo? packageInfo}) {
    options = (baseOptions ?? BaseOptions()).copyWith(
      validateStatus: (int? status) {
        return status != null && status >= 200 && status < 400;
      },
    );

    // !!!! DO NOT USE THIS ON WEB BUILD !!!!
    // httpClientAdapter = NativeAdapter(
    //   createCupertinoConfiguration: () =>
    //       URLSessionConfiguration.ephemeralSessionConfiguration()
    //         ..allowsCellularAccess = false
    //         ..allowsConstrainedNetworkAccess = false
    //         ..allowsExpensiveNetworkAccess = false,
    // );

    httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

    interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(),
      UserAgentInterceptor(packageInfo),
      RetryInterceptor(
        dio: HttpClient(),
        logPrint: print, // specify log function (optional)
        retries: 4, // retry count (optional)
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 1), // wait 1 sec before the first retry
          Duration(seconds: 2), // wait 2 sec before the second retry
          Duration(seconds: 3), // wait 3 sec before the third retry
          Duration(seconds: 4), // wait 4 sec before the fourth retry
        ],
      ),
    ]);

    if (!isLinux) {
      interceptors.add(DioFirebasePerformanceInterceptor());
    }

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
