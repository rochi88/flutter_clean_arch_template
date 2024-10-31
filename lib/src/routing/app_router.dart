// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../features/auth/presentation/providers/auth_controller_provider.dart';
import '../features/home/presentation/views/home_screen.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

enum AppRoute { home }

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final authRepository = ref.watch(authControllerProvider);
  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signin') {
          return '/catalogue';
        }
      } else {
        if (path == '/account' || path == '/orders') {
          return '/catalogue';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => HomeScreen(),
      ),
    ],
    observers: (!kDebugMode)
        ? [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)]
        : [],
  );
}
