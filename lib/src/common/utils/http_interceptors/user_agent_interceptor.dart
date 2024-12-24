// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import '../../../env.dart';

class UserAgentInterceptor extends Interceptor {
  UserAgentInterceptor(this.packageInfo);

  final PackageInfo? packageInfo;

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!kIsWeb) {
      options.headers['User-Agent'] =
          '${packageInfo?.appName} - ${packageInfo?.packageName}/${packageInfo?.version}+${packageInfo?.buildNumber} - ApiVersion/${Env.apiVersion} - Dart/${Platform.version} - OS: ${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
    }
    handler.next(options);
  }
}
