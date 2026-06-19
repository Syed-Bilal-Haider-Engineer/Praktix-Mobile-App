import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/datasources/mock/mock_data.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/home_provider.dart';
import '../../../presentation/providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull ?? MockData.mockUser;
    final homeAsync = ref.watch(homeDataProvider);
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    final enrolledPrograms =
        homeAsync.whenOrNull(
          data: (home) => home.programs
              .where((p) => user.enrolledProgramIds.contains(p.id))
              .toList(),
        ) ??
        [];

    final savedOpportunities =
        homeAsync.whenOrNull(
          data: (home) => home.opportunities
              .where((o) => user.savedOpportunityIds.contains(o.id))
              .toList(),
        ) ??
        [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: user.avatarUrl != null
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user.avatarUrl!,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.primary,
                      ),
              ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                user.email,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatBadge(
                    icon: Icons.local_fire_department,
                    label: '${user.learningStreak} day streak',
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  _StatBadge(
                    icon: Icons.star,
                    label: '${user.totalXp} XP',
                    color: AppColors.warning,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSettingsTile(
                context,
                icon: Icons.dark_mode_outlined,
                title: AppStrings.darkMode,
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) =>
                      ref.read(themeModeProvider.notifier).toggleDarkMode(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.enrolledPrograms,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (enrolledPrograms.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No enrolled programs yet'),
                )
              else
                ...enrolledPrograms.map(
                  (program) => ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                      child: const Icon(Icons.school, color: AppColors.primary),
                    ),
                    title: Text(program.title),
                    subtitle: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: program.progress,
                        minHeight: 4,
                      ),
                    ),
                    trailing: Text('${(program.progress * 100).toInt()}%'),
                    onTap: () => context.push('/program/${program.id}'),
                  ),
                ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.certificates,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...MockData.certificates.map(
                (cert) => ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.success.withValues(alpha: 0.1),
                    ),
                    child: const Icon(Icons.verified, color: AppColors.success),
                  ),
                  title: Text(cert.title),
                  subtitle: Text(
                    '${cert.programName} · ${DateFormat('MMM yyyy').format(cert.issuedDate)}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.savedOpportunities,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (savedOpportunities.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No saved opportunities'),
                )
              else
                ...savedOpportunities.map(
                  (opp) => ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondary.withValues(alpha: 0.1),
                      ),
                      child: const Icon(Icons.work, color: AppColors.secondary),
                    ),
                    title: Text(opp.title),
                    subtitle: Text('${opp.company} · ${opp.location}'),
                  ),
                ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) context.go(AppRoutes.login);
                  },
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: const Text(
                    AppStrings.logout,
                    style: TextStyle(color: AppColors.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.isDarkMode
              ? AppColors.borderDark
              : AppColors.borderLight,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: trailing,
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
