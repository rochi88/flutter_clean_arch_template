// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launcher_provider.g.dart';

/// A simple wrapper for the url_launcher package
class UrlLauncher {
  const UrlLauncher();

  static const _name = 'URL Launcher';

  Future<bool> launch(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        log('Launching URL: $uri', name: _name);
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      } else {
        log('Cannot launch URL: $uri', name: _name);
        // TODO: Error monitoring
        return false;
      }
    } catch (e, st) {
      log(
        'Failed launching URL: $uri, $e',
        name: _name,
        error: e,
        stackTrace: st,
      );
      // TODO: Error monitoring
      return false;
    }
  }
}

@riverpod
UrlLauncher urlLauncher(Ref ref) {
  return const UrlLauncher();
}
