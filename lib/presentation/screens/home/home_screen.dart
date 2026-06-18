import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/expert_card.dart';
import '../../../core/widgets/program_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/workshop_card.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/home_provider.dart';

/// Home Screen — main dashboard with all content sections.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeDataProvider);
    final user = ref.watch(authProvider).valueOrNull;

    return Scaffold(
      body: SafeArea(
        child: homeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (home) => RefreshIndicator(
            onRefresh: () => ref.refresh(homeDataProvider.future),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context, user?.name ?? 'Learner')),
                SliverToBoxAdapter(child: _buildProgressCard(context, user)),
                SliverToBoxAdapter(child: _buildAiRecommendation(context)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.featuredPrograms),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 12, 4, 0),
                      itemCount: home.programs.length,
                      itemBuilder: (_, i) => ProgramCard(
                        program: home.programs[i],
                        onTap: () => context.push(
                          '/program/${home.programs[i].id}',
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.featuredExperts),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 12, 4, 0),
                      itemCount: home.experts.length,
                      itemBuilder: (_, i) => ExpertCard(
                        expert: home.experts[i],
                        onTap: () => context.push(
                          '/expert/${home.experts[i].id}',
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.upcomingWorkshops),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => WorkshopCard(workshop: home.workshops[i]),
                    childCount: home.workshops.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: SectionHeader(title: AppStrings.recommendedOpportunities),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => OpportunityCard(opportunity: home.opportunities[i]),
                    childCount: home.opportunities.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${name.split(' ').first} 👋',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.notifications_outlined, color: AppColors.primary),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }

  Widget _buildProgressCard(BuildContext context, dynamic user) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
              const SizedBox(width: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${user?.totalXp ?? 2450} XP',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.yourProgress,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.48,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              color: Colors.white,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '48% overall completion',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.3),
        ),
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
            child: const Icon(Icons.auto_awesome, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
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
}
