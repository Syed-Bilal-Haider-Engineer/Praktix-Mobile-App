// lib/presentation/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // 👈 Updated Top Header Circle with a clean Person Icon layout
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(
                  Icons.person,
                  size: 44, // Perfectly proportioned inner icon size
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
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 12),

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
                  activeColor: AppColors.primary,
                  onChanged: (_) =>
                      ref.read(themeModeProvider.notifier).toggleDarkMode(),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, AppStrings.enrolledPrograms),
              const SizedBox(height: 8),
              if (enrolledPrograms.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No enrolled programs yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...enrolledPrograms.map(
                  (program) => ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.school, color: AppColors.primary),
                    ),
                    title: Text(
                      program.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: program.progress,
                          minHeight: 5,
                          backgroundColor: isDark
                              ? Colors.black26
                              : Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    trailing: Text(
                      '${(program.progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    onTap: () => context.push('/program/${program.id}'),
                  ),
                ),

              const SizedBox(height: 20),
              _buildSectionHeader(context, AppStrings.certificates),
              const SizedBox(height: 8),
              ...MockData.certificates.map(
                (cert) => ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.success.withOpacity(0.1),
                    ),
                    child: const Icon(Icons.verified, color: AppColors.success),
                  ),
                  title: Text(
                    cert.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${cert.programName} · ${DateFormat('MMM yyyy').format(cert.issuedDate)}',
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _buildSectionHeader(context, AppStrings.savedOpportunities),
              const SizedBox(height: 8),
              if (savedOpportunities.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No saved opportunities',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...savedOpportunities.map(
                  (opp) => ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondary.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.work, color: AppColors.secondary),
                    ),
                    title: Text(
                      opp.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${opp.company} · ${opp.location}'),
                  ),
                ),

              const SizedBox(height: 32),

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
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: AppColors.error, width: 1.5),
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
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
    final isDark = context.isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
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
        color: color.withOpacity(0.1),
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
