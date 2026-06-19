import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../utils/extensions.dart';
import 'branded_logo.dart';
import 'decorated_background.dart';

/// Branded header block shared across auth screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showLogo = true,
    this.centered = false,
  });

  final String title;
  final String subtitle;
  final bool showLogo;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final alignment = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (showLogo) ...[
          BrandedLogo(sizeFactor: 0.4),
          const SizedBox(height: AppSpacing.lg),
        ],
        Text(
          title,
          textAlign: textAlign,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          textAlign: textAlign,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// Centers auth form content with responsive max width.
class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.child,
    this.showSoftBackground = true,
  });

  final Widget child;
  final bool showSoftBackground;

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);
    final maxWidth = AppSpacing.contentMaxWidth(context);

    Widget content = SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ),
    );

    if (showSoftBackground) {
      content = SoftDecoratedBackground(child: content);
    }
    return content;
  }
}
