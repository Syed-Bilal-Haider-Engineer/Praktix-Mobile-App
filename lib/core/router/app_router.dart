import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:praktix/presentation/screens/profile/profile_screen.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/home/main_shell.dart';
import '../../presentation/screens/about/about_screen.dart';
import '../../presentation/screens/program/program_detail_screen.dart';
import '../../presentation/screens/expert/expert_profile_screen.dart';

/// Uniform structural paths for safe app navigation hooks.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const about = '/about';
  static const program = '/program/:id';
  static const profile = '/profile';
  static const expert = '/expert/:id';
}

/// Dynamic GoRouter definition powered by Riverpod state streams.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final storage = ref.watch(localStorageProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isOnboarding = state.matchedLocation == AppRoutes.onboarding;
      final isAuth =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.forgotPassword;

      if (isSplash) return null;

      final isLoggedIn =
          authState.whenOrNull(data: (user) => user != null) ?? false;
      final onboardingDone = storage.isOnboardingComplete;

      if (!onboardingDone && !isOnboarding) {
        return AppRoutes.onboarding;
      }

      if (!isLoggedIn && !isAuth && !isOnboarding) {
        return AppRoutes.login;
      }

      if (isLoggedIn && isAuth) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, _) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: AppRoutes.home, builder: (_, _) => const MainShell()),
      GoRoute(path: AppRoutes.about, builder: (_, _) => const AboutScreen()),
      GoRoute(
        path: AppRoutes.program,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return ProgramDetailScreen(programId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.expert,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return ExpertProfileScreen(expertId: id); // ✅ just pass the id
        },
      ),
    ],
  );
});
