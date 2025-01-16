// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'firebase_options.dart';
import 'src/app_dev.dart';
import 'src/common/exceptions/async_error_logger.dart';
import 'src/common/exceptions/error_logger.dart';
import 'src/common/localization/string_hardcoded.dart';
import 'src/common/providers/http_client_provider.dart';
import 'src/common/providers/package_info_provider.dart';
import 'src/common/providers/shared_preferences_provider.dart';
import 'src/common/services/notification/notification_service.dart';
import 'src/common/utils/target_platform.dart';

late String tempPath;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.setupFlutterNotifications();
  await NotificationService.showFlutterNotification(message);
}

Future<void> main() async {
  await runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      // Retain native splash screen until Dart is ready
      if (!kIsWeb) {
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
        tempPath = (await getTemporaryDirectory()).path;
      }

      if (isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }

      if (!isLinux) {
        await _initializeApp();
      }

      final container = ProviderContainer(
        observers: [AsyncErrorLogger()],
      );
      // * Preload SharedPreferences before calling runApp,
      // * app depends on it in order to load the themeMode
      container.read(sharedPreferencesProvider.future);
      container.read(packageInfoProvider.future);
      container.read(httpClientProvider);
      final errorLogger = container.read(errorLoggerProvider);
      // * Register error handlers. For more info, see:
      // * https://docs.flutter.dev/testing/errors
      registerErrorHandlers(errorLogger);

      runApp(
        DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) {
              return UncontrolledProviderScope(
                container: container,
                child: EasyLocalization(
                  path: 'assets/translations',
                  supportedLocales: const [
                    Locale('en'),
                    Locale('bn'),
                  ],
                  fallbackLocale: const Locale('en'),
                  child: const DevApp(),
                ),
              );
            }),
      );

      if (!kIsWeb) {
        FlutterNativeSplash.remove();
      }
    },
    (error, stacktrace) {
      if (!isLinux || !kIsWeb) {
        FirebaseCrashlytics.instance
            .recordError(error, stacktrace, fatal: true);
      }
      if (kDebugMode) {
        print('Error: $error');
        print('Stacktrace: $stacktrace');
      }
    },
  );
}

Future<void> _initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebasePerformance.instance
      .setPerformanceCollectionEnabled(!kDebugMode);

  if (!kIsWeb) {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);

    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
    );

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage
        .listen(NotificationService.showFlutterNotification);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await NotificationService.setupFlutterNotifications();
  }
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
