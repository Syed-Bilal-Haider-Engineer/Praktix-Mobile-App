import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Keeps Flutter web looking like a mobile app on desktop browsers.
class ResponsiveAppFrame extends StatelessWidget {
  const ResponsiveAppFrame({super.key, required this.child});

  final Widget child;

  static const double _mobilePreviewWidth = 430;
  static const double _frameBreakpoint = 560;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    final media = MediaQuery.of(context);
    final screenSize = media.size;
    final shouldFrame = screenSize.width > _frameBreakpoint;

    if (!shouldFrame) return child;

    final appWidth = math.min(_mobilePreviewWidth, screenSize.width);
    final framedMedia = media.copyWith(size: Size(appWidth, screenSize.height));

    final outerColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;

    return ColoredBox(
      color: outerColor,
      child: Center(
        child: Container(
          width: appWidth,
          height: screenSize.height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: MediaQuery(data: framedMedia, child: child),
        ),
      ),
    );
  }
}
