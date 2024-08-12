import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/home/presentation/home_screen/home_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  home
}

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
