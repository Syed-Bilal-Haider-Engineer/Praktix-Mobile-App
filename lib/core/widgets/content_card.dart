import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../utils/extensions.dart';

/// Shared card decoration used across list and grid items.
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.onTap,
    this.borderRadius = AppSpacing.cardRadius,
    this.showShadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
      border: Border.all(
        color: context.isDarkMode ? AppColors.borderDark : AppColors.borderLight,
      ),
      boxShadow: showShadow
          ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: context.isDarkMode ? 0.2 : 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );

    final content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );

    final card = Container(
      margin: margin,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }
    return card;
  }
}
