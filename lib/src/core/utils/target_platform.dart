// Flutter imports:
import 'package:flutter/foundation.dart';

bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
