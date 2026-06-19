import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/branded_logo.dart';
import '../../../core/widgets/decorated_background.dart';
import '../../../presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Splash Screen — first screen users see.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(AppConstants.splashDuration);
    if (!mounted) return;

    final storage = ref.read(localStorageProvider);
    if (!storage.isOnboardingComplete) {
      context.go(AppRoutes.onboarding);
    } else if (storage.authToken != null) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: DecoratedBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: size.width >= 600 ? 420 : size.width,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.pagePadding(context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: BrandedLogo(sizeFactor: 0.28),
                        )
                            .animate()
                            .scale(
                              begin: const Offset(0.6, 0.6),
                              end: const Offset(1, 1),
                              duration: 900.ms,
                              curve: Curves.elasticOut,
                            )
                            .fadeIn(),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          AppConstants.appName,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                height: 1.1,
                              ),
                          textAlign: TextAlign.center,
                        )
                            .animate()
                            .fadeIn(delay: 350.ms)
                            .slideY(begin: 0.25, end: 0, curve: Curves.easeOut),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          AppConstants.appTagline,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 550.ms),
                        const Spacer(flex: 2),
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ).animate().fadeIn(delay: 750.ms),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
