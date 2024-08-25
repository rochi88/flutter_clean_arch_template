// Package imports:
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import '../features/home/presentation/views/home_screen.dart';

part 'app_router.g.dart';

enum AppRoute { home }

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    observers: (!kDebugMode)
        ? [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)]
        : [],
  );
}
