import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/branded_logo.dart';
import '../../../core/widgets/decorated_background.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../presentation/providers/providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  List<_OnboardingPageData> get _pages => [
    _OnboardingPageData(
      visual: const SizedBox(
        width: 132,
        height: 132,
        child: BrandedLogo(sizeFactor: 0.22, minSize: 82, maxSize: 108),
      ),
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      accentColor: AppColors.primary,
      showIconBackground: false,
    ),
    _OnboardingPageData(
      visual: _OnboardingIllustration(
        icon: Icons.verified_rounded,
        color: AppColors.secondary,
        secondaryIcon: Icons.workspace_premium_rounded,
      ),
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDesc2,
      accentColor: AppColors.secondary,
    ),
    _OnboardingPageData(
      visual: _OnboardingIllustration(
        icon: Icons.rocket_launch_rounded,
        color: AppColors.accent,
        secondaryIcon: Icons.trending_up_rounded,
      ),
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDesc3,
      accentColor: AppColors.accent,
    ),
  ];

  Future<void> _completeOnboarding() async {
    await ref.read(localStorageProvider).setOnboardingComplete(true);
    if (mounted) context.go(AppRoutes.login);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);

    return Scaffold(
      body: SoftDecoratedBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  padding,
                  AppSpacing.sm,
                  padding,
                  0,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text('Skip'),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (_, index) =>
                      _OnboardingPage(page: _pages[index]),
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: _pages[_currentPage].accentColor,
                  dotColor: context.isDarkMode
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: PrimaryButton(
                  label: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Continue',
                  onPressed: _nextPage,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.visual,
    required this.title,
    required this.description,
    required this.accentColor,
    this.showIconBackground = true,
  });

  final Widget visual;
  final String title;
  final String description;
  final Color accentColor;
  final bool showIconBackground;
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({
    required this.icon,
    required this.color,
    required this.secondaryIcon,
  });

  final IconData icon;
  final Color color;
  final IconData secondaryIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.08),
                ],
              ),
            ),
            child: Icon(icon, size: 52, color: color),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? AppColors.cardDark : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(secondaryIcon, size: 20, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.page});

  final _OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final visualSize =
            (constraints.maxHeight * 0.26).clamp(136.0, 172.0).toDouble();
        final gap = constraints.maxHeight < 560 ? AppSpacing.lg : AppSpacing.xxl;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: AppSpacing.md,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: visualSize,
                height: visualSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: page.showIconBackground
                        ? page.accentColor.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Center(child: page.visual),
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              SizedBox(height: gap),
              Text(
                page.title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15, end: 0),
              const SizedBox(height: AppSpacing.md),
              Text(
                page.description,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  height: 1.55,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 350.ms),
            ],
          ),
        );
      },
    );
  }
}
