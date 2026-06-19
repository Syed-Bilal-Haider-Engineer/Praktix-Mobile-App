import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/opportunity.dart';
import '../../data/models/workshop.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../utils/extensions.dart';
import 'app_image.dart';
import 'content_card.dart';

class WorkshopCard extends StatelessWidget {
  const WorkshopCard({super.key, required this.workshop});

  final Workshop workshop;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return ContentCard(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding(context),
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: AppImage(
              imagePath: workshop.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.cardRadius),
              ),
              placeholderIcon: Icons.event,
              placeholderColor: AppColors.accent,
              semanticLabel: '${workshop.title} banner',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: (workshop.isOnline ? AppColors.accent : AppColors.secondary)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            workshop.isOnline ? Icons.videocam : Icons.location_on,
                            size: 12,
                            color: workshop.isOnline ? AppColors.accent : AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            workshop.isOnline ? 'Online' : 'In-person',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: workshop.isOnline ? AppColors.accent : AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: context.isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateFormat.format(workshop.date),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  workshop.title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${workshop.time} · with ${workshop.speaker}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
    this.onSave,
  });

  final Opportunity opportunity;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding(context),
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.isDarkMode ? AppColors.borderDark : AppColors.borderLight,
              ),
              color: context.isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
            ),
            clipBehavior: Clip.antiAlias,
            child: AppImage(
              imagePath: opportunity.imageUrl,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              placeholderIcon: Icons.business,
              placeholderColor: AppColors.secondary,
              semanticLabel: '${opportunity.company} logo',
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opportunity.title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  opportunity.company,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: context.isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        opportunity.location,
                        style: context.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    opportunity.type,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (onSave != null)
            IconButton(
              onPressed: onSave,
              icon: Icon(
                opportunity.isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: opportunity.isSaved ? AppColors.primary : null,
              ),
              tooltip: opportunity.isSaved ? 'Remove bookmark' : 'Save opportunity',
            ),
        ],
      ),
    );
  }
}
