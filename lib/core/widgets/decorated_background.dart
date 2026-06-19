import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Layered gradient background with subtle decorative circles.
class DecoratedBackground extends StatelessWidget {
  const DecoratedBackground({
    super.key,
    required this.child,
    this.gradient = AppColors.primaryGradient,
    this.showDecorations = true,
  });

  final Widget child;
  final Gradient gradient;
  final bool showDecorations;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showDecorations) ...[
            Positioned(
              top: -80,
              right: -60,
              child: _DecorativeCircle(
                size: MediaQuery.sizeOf(context).width * 0.55,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: _DecorativeCircle(
                size: MediaQuery.sizeOf(context).width * 0.65,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.35,
              left: -30,
              child: _DecorativeCircle(
                size: 120,
                color: AppColors.accent.withValues(alpha: 0.12),
              ),
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * 0.25,
              right: 40,
              child: _DecorativeCircle(
                size: 64,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

/// Soft tinted circles for light auth/onboarding backgrounds.
class SoftDecoratedBackground extends StatelessWidget {
  const SoftDecoratedBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: _DecorativeCircle(
            size: 200,
            color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.06),
          ),
        ),
        Positioned(
          bottom: 120,
          left: -50,
          child: _DecorativeCircle(
            size: 160,
            color: AppColors.secondary.withValues(alpha: isDark ? 0.06 : 0.05),
          ),
        ),
        child,
      ],
    );
  }
}
