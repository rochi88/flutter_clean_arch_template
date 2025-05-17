// Flutter imports:
import 'package:flutter/material.dart';

/// Converts a [String] representing a color in hex format to a [Color].
///
/// The hex color string can be with or without the leading '#'. If the
/// string is of length 6, it is assumed to be without the leading '#'
/// and it is prepended before conversion.
Color? hexStringToColor(String? hexColor) {
  if (hexColor == null) return null;
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  try {
    return Color(int.parse(hexColor, radix: 16));
  } on FormatException {
    return null;
  }
}
