import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_assets.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../utils/extensions.dart';
import 'app_image.dart';
import 'content_card.dart';

/// About Praktix section with image and mission text.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(padding, AppSpacing.lg, padding, 0),
      child: ContentCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.cardRadius),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: AppImage(
                  imagePath: AppAssets.aboutImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholderIcon: Icons.groups_outlined,
                  placeholderColor: AppColors.secondary,
                  semanticLabel: 'About Praktix',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.aboutTitle,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...AppStrings.aboutParagraphs.map(
                    (paragraph) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Text(
                        paragraph,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          height: 1.65,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.06, end: 0);
  }
}
