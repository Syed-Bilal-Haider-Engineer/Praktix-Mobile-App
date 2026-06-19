import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}

extension StringExtensions on String {
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get firstName {
    final trimmed = trim();
    if (trimmed.isEmpty) return this;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  /// Derives a display name from an email local part (e.g. john.doe → John Doe).
  static String nameFromEmail(String email) {
    final local = email.split('@').first;
    return local
        .split(RegExp(r'[._-]+'))
        .where((part) => part.isNotEmpty)
        .map((part) => part.capitalize)
        .join(' ');
  }
}
