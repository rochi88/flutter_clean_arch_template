// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_clean_arch_template/src/app.dart';
import 'package:flutter_clean_arch_template/src/core/providers/http_client_provider.dart';
import 'package:flutter_clean_arch_template/src/core/providers/shared_preferences_provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final container = ProviderContainer();
    // * Preload SharedPreferences before calling runApp,
    // * app depends on it in order to load the themeMode
    container.read(sharedPreferencesProvider);
    container.read(httpClientProvider);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: MyApp()),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
