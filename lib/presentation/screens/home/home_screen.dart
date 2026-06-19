// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
// import '../../../core/widgets/about_section.dart';
import '../../../core/widgets/expert_card.dart';
import '../../../core/widgets/program_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/workshop_card.dart';
import '../../../data/models/user.dart';
import '../../../data/models/expert.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeDataProvider);
    final authAsync = ref.watch(authProvider);
    final user = authAsync.valueOrNull;
    final pagePadding = AppSpacing.pagePadding(context);

    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: homeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (home) => RefreshIndicator(
            onRefresh: () => ref.refresh(homeDataProvider.future),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(context, user, authAsync.isLoading),
                ),
                SliverToBoxAdapter(child: _buildProgressCard(context, user)),
                SliverToBoxAdapter(child: _buildAiRecommendation(context)),
                // const SliverToBoxAdapter(child: AboutSection()),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.featuredPrograms),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppSpacing.horizontalListHeight(context, 280),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(pagePadding, 12, 4, 0),
                      itemCount: home.programs.length,
                      itemBuilder: (_, i) => ProgramCard(
                        program: home.programs[i],
                        onTap: () =>
                            context.push('/program/${home.programs[i].id}'),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
                SliverToBoxAdapter(
                  child: _buildExpertsSection(context, home.experts),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.upcomingWorkshops),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => WorkshopCard(workshop: home.workshops[i]),
                    childCount: home.workshops.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
                SliverToBoxAdapter(
                  child: SectionHeader(
                    title: AppStrings.recommendedOpportunities,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) =>
                        OpportunityCard(opportunity: home.opportunities[i]),
                    childCount: home.opportunities.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel? user, bool isLoading) {
    final displayName = isLoading ? '...' : (user?.name.firstName ?? 'Learner');

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pagePadding(context),
        AppSpacing.md,
        AppSpacing.pagePadding(context),
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                    children: [
                      const TextSpan(text: 'Hello, '),
                      TextSpan(
                        text: displayName,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Continue your learning journey',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () =>
                context.push('/profile'), // or whatever your profile route is
            child: CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: ClipOval(
                child: user?.avatarUrl != null
                    ? Image.network(
                        user!.avatarUrl!,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 22,
                      ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }

  Widget _buildProgressCard(BuildContext context, UserModel? user) {
    const double progress = 0.48;

    return Container(
      margin: EdgeInsets.all(AppSpacing.pagePadding(context)),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${user?.learningStreak ?? 12} day streak',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${user?.totalXp ?? 2450} XP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.yourProgress,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              color: Colors.white,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            '48% overall completion',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildAiRecommendation(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding(context)),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: context.isDarkMode ? 0.15 : 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.accent,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.aiRecommendations,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Based on your profile, try "AI for Developers" next',
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildExpertsSection(BuildContext context, List<Expert> experts) {
    final pagePadding = AppSpacing.pagePadding(context);

    return Container(
      color: const Color(0xFF0B1628),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: AppStrings.featuredExperts, inverted: true),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(pagePadding, 12, 4, 12),
              itemCount: experts.length,
              itemBuilder: (ctx, i) => ExpertCard(
                expert: experts[i],
                onTap: () => ctx.push('/expert/${experts[i].id}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
