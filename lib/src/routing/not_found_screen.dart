// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../core/localization/string_hardcoded.dart';
import '../core/widgets/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(message: '404 - Page not found!'.hardcoded),
    );
  }
}
