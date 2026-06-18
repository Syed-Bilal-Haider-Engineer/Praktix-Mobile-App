import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
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

  List<_OnboardingPage> get _pages => [
        _OnboardingPage(
          imageOrIcon: SizedBox(
            width: 140,
            height: 140,
            child: Image.asset(
              'assets/images/logo.webp',
              fit: BoxFit.contain,
            ),
          ),
          title: AppStrings.onboardingTitle1,
          description: AppStrings.onboardingDesc1,
          color: AppColors.primary,
          showBackground: false, // 👈 Works perfectly now!
        ),
        const _OnboardingPage(
          imageOrIcon: Icon(Icons.verified_rounded, size: 64, color: AppColors.secondary),
          title: AppStrings.onboardingTitle2,
          description: AppStrings.onboardingDesc2,
          color: AppColors.secondary,
          showBackground: true, 
        ),
        const _OnboardingPage(
          imageOrIcon: Icon(Icons.rocket_launch_rounded, size: 64, color: AppColors.accent),
          title: AppStrings.onboardingTitle3,
          description: AppStrings.onboardingDesc3,
          color: AppColors.accent,
          showBackground: true, 
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
    final pagesList = _pages; 

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pagesList.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (_, index) => pagesList[index],
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: pagesList.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.borderLight,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                label: _currentPage == pagesList.length - 1 ? 'Get Started' : 'Continue',
                onPressed: _nextPage,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.imageOrIcon,
    required this.title,
    required this.description,
    required this.color,
    this.showBackground = true, 
  });

  final Widget imageOrIcon; 
  final String title;
  final String description;
  final Color color;
  final bool showBackground; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: showBackground ? color.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(child: imageOrIcon),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}