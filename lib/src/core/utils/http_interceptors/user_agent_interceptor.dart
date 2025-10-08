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
  static PackageInfo? _cachedInfo;

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Always set CCApp header
    options.headers['CCApp'] = 'true';

    // Add User-Agent only if not web
    if (!kIsWeb) {
      final packageInfo = _cachedInfo ??= await PackageInfo.fromPlatform();
      options.headers['User-Agent'] =
          '${packageInfo.appName} - ${packageInfo.packageName}/${packageInfo.version}+${packageInfo.buildNumber} - ApiVersion/${Env.apiVersion} - Dart/${Platform.version} - OS: ${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
    } else {
      // Optional: custom header for web
      options.headers['User-Agent'] =
          'Octopus Web - ApiVersion/${Env.apiVersion}';
    }

    handler.next(options);
  }
}
