
/// Centralizing magic strings and numbers makes the app easier to maintain.
class AppConstants {
  AppConstants._();

  static const String appName = 'Praktix';
  static const String appTagline = 'Real outcomes.';

  // Local storage keys (like localStorage keys in the browser)
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyAuthToken = 'auth_token';
  static const String keyUserData = 'user_data';
  static const String keyThemeMode = 'theme_mode';
  static const String keyCachedPrograms = 'cached_programs';
  static const String keyCachedExperts = 'cached_experts';

  // Splash screen duration
  static const Duration splashDuration = Duration(seconds: 3);

  // Mock API delay to simulate network latency
  static const Duration mockApiDelay = Duration(milliseconds: 800);
}
