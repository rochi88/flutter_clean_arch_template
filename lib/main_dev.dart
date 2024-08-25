// Dart imports:
import 'dart:async';
import 'dart:io';

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
import 'src/core/services/notification/fcm_notification.dart';

late String? tempPath;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Set the path to the temporary directory
  if (!kIsWeb) {
    tempPath = (await getTemporaryDirectory()).path;
  }

  // Retain native splash screen until Dart is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (!(defaultTargetPlatform == TargetPlatform.linux)) {
    await _initializeApp();
  }

  runZonedGuarded(
      () => runApp(
            DevicePreview(
                enabled: !kReleaseMode,
                builder: (context) {
                  return ProviderScope(
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
          ), (error, stacktrace) {
    FirebaseCrashlytics.instance.recordError(error, stacktrace, fatal: true);
    if (kDebugMode) {
      print('Error: $error');
      print('Stacktrace: $stacktrace');
    }
  });
  FlutterNativeSplash.remove();
}

Future<void> _initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);
  await FirebasePerformance.instance
      .setPerformanceCollectionEnabled(!kDebugMode);

  await FirebaseMessaging.instance.requestPermission(
    provisional: true,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
}
