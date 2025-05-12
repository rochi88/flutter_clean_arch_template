// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
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
import 'src/app.dart';
import 'src/core/providers/http_client_provider.dart';
import 'src/core/providers/shared_preferences_provider.dart';
import 'src/core/services/notification/fcm_notification.dart';
import 'src/core/utils/target_platform.dart';

late String tempPath;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

Future<void> main() async {
  await runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    // Retain native splash screen until Dart is ready
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    if (!kIsWeb) {
      tempPath = (await getTemporaryDirectory()).path;
    }

    if (isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    if (!isLinux) {
      await _initializeApp();
    }

    final container = ProviderContainer();
    // * Preload SharedPreferences before calling runApp,
    // * app depends on it in order to load the themeMode
    container.read(sharedPreferencesProvider);
    container.read(httpClientProvider);

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [
            Locale('en'),
            Locale('bn'),
          ],
          fallbackLocale: const Locale('en'),
          child: const MyApp(),
        ),
      ),
    );

    FlutterNativeSplash.remove();
  }, (error, stacktrace) {
    if (!isLinux || !kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stacktrace, fatal: true);
    }
    if (kDebugMode) {
      print('Error: $error');
      print('Stacktrace: $stacktrace');
    }
  });
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

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupFlutterNotifications();
  }
}
