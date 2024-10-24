// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'core/localization/string_hardcoded.dart';
import 'core/providers/app_theme_mode_provider.dart';
import 'core/themes/app_themes.dart';
import 'routing/app_router.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final themeMode = ref.watch(appThemeModeNotifierProvider);

    return isIOS
        ? ScreenUtilInit(
            designSize: const Size(
                393, 852), // viewport size of iPhone 14 Pro, iPhone 15
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return CupertinoApp.router(
                routerConfig: appRouter,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: AppThemes.ilight(),
              );
            })
        : ScreenUtilInit(
            designSize:
                const Size(393, 851), // viewport size of Google Pixel 4a
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp.router(
                routerConfig: appRouter,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                restorationScopeId: 'app',
                onGenerateTitle: (BuildContext context) => 'Example'.hardcoded,
                themeMode: themeMode,
                theme: AppThemes.light(),
                darkTheme: AppThemes.dark(),
              );
            });
  }
}
