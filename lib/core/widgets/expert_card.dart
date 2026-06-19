// lib/core/widgets/expert_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/models/expert.dart';
import '../theme/app_colors.dart';
import '../utils/extensions.dart';

class ExpertCard extends StatelessWidget {
  const ExpertCard({
    super.key,
    required this.expert,
    required this.onTap,
  });

  final Expert expert;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
          border: Border.all(
            color: context.isDarkMode ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: ClipOval(
                child: expert.imageUrl.startsWith('assets/')
                    ? Image.asset(
                        expert.imageUrl,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.person, color: AppColors.primary),
                      )
                    : CachedNetworkImage(
                        imageUrl: expert.imageUrl,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        placeholder: (_, _) =>
                            const Icon(Icons.person, color: AppColors.primary),
                        errorWidget: (_, _, _) =>
                            const Icon(Icons.person, color: AppColors.primary),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              expert.name,
              style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              expert.specialization,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}