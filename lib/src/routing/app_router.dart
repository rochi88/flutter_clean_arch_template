// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../core/observer/app_navigator_observer.dart';
import '../core/providers/app_state_provider.dart';
import '../features/auth/presentation/providers/auth_controller_provider.dart';
import '../features/auth/presentation/views/signin_screen.dart';
import '../features/home/presentation/views/home_screen.dart';
import '../features/onboarding/presentation/views/onboarding_screen.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';

part 'app_router.g.dart';

enum AppRoute { home, onboarding, signin }

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final authRepository = ref.watch(authControllerProvider);
  final appState = ref.watch(appStateNotifierProvider);
  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: appState.onboardingCompleted ? '/signin' : '/onboarding',
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signin') {
          return '/home';
        }
      } else {
        return appState.onboardingCompleted ? '/signin' : '/onboarding';
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
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/signin',
        name: AppRoute.signin.name,
        builder: (context, state) => SigninScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
    observers:
        (kDebugMode)
            ? [AppNavigatorObserver()]
            : [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ],
  );
}
