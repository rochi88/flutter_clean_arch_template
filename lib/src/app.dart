import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:easy_localization/easy_localization.dart';
import '../src/core/localization/string_hardcoded.dart';
import '../src/core/providers/dark_mode.dart';
import '../src/core/styles/app_themes.dart';
import '../src/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final darkMode = ref.watch(darkModeProvider);

    return isIOS
        ? CupertinoApp.router(
            routerConfig: appRouter,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.idark(),
          )
        : MaterialApp.router(
            routerConfig: appRouter,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            onGenerateTitle: (BuildContext context) => 'Example'.hardcoded,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppThemes.light(),
            darkTheme: AppThemes.dark(),
          );
  }
}
