import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../presentation/providers/home_provider.dart';
import '../../../presentation/providers/providers.dart';

class ExpertProfileScreen extends ConsumerStatefulWidget {
  const ExpertProfileScreen({super.key, required this.expertId});

  final String expertId;

  @override
  ConsumerState<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends ConsumerState<ExpertProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final expertAsync = ref.watch(expertDetailProvider(widget.expertId));

    return Scaffold(
      body: expertAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (expert) {
          if (expert == null) {
            return const Center(child: Text('Expert not found'));
          }

          _isFollowing = expert.isFollowing;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -50),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundImage: expert.imageUrl.startsWith('assets/')
    ? AssetImage(expert.imageUrl)
    : CachedNetworkImageProvider(expert.imageUrl) as ImageProvider,
                        ),
                      ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 12),
                      Text(
                        expert.name,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expert.title,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expert.specialization,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  await ref
                                      .read(expertRepositoryProvider)
                                      .toggleFollow(expert.id);
                                  setState(() => _isFollowing = !_isFollowing);
                                },
                                icon: Icon(
                                  _isFollowing ? Icons.check : Icons.add,
                                  size: 18,
                                ),
                                label: Text(
                                  _isFollowing ? AppStrings.following : AppStrings.follow,
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Mentorship booking coming soon!'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.calendar_month, size: 18),
                                label: const Text(AppStrings.bookMentorship),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              expert.bio,
                              style: context.textTheme.bodyLarge?.copyWith(height: 1.6),
                            ),
                            const SizedBox(height: 24),
                            _buildInfoRow(
                              context,
                              Icons.work_history,
                              AppStrings.experience,
                              expert.experience,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              AppStrings.availablePrograms,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...expert.programIds.map(
                              (id) => ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.school, color: AppColors.primary, size: 20),
                                ),
                                title: Text(_programName(id)),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () => context.push('/program/$id'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.isDarkMode ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.textTheme.bodySmall),
                Text(
                  value,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _programName(String id) {
    return switch (id) {
      'prog-1' => 'AI for Managers',
      'prog-2' => 'AI for Developers',
      'prog-3' => 'AI for Healthcare',
      'prog-4' => 'Cybersecurity Internship',
      _ => 'Program',
    };
  }
}
