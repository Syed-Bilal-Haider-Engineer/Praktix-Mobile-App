import 'package:flutter/material.dart';

/// Shared spacing tokens and responsive layout helpers.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double cardRadius = 16;
  static const double cardRadiusLg = 20;

  static double pagePadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 48;
    if (width >= 600) return 32;
    return 20;
  }

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 480;
    if (width >= 600) return 420;
    return width;
  }

  static double logoSize(BuildContext context, {double factor = 0.28}) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * factor).clamp(96.0, 160.0);
  }

  static double horizontalListHeight(BuildContext context, double base) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return base * 1.15;
    if (width >= 600) return base * 1.08;
    return base;
  }
}
