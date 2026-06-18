import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  // --- Onboarding ---
  bool get isOnboardingComplete =>
      _prefs.getBool(AppConstants.keyOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete(bool value) =>
      _prefs.setBool(AppConstants.keyOnboardingComplete, value);

  // --- Auth ---
  String? get authToken => _prefs.getString(AppConstants.keyAuthToken);

  Future<void> setAuthToken(String? token) async {
    if (token == null) {
      await _prefs.remove(AppConstants.keyAuthToken);
    } else {
      await _prefs.setString(AppConstants.keyAuthToken, token);
    }
  }

  String? get userData => _prefs.getString(AppConstants.keyUserData);

  Future<void> setUserData(String? data) async {
    if (data == null) {
      await _prefs.remove(AppConstants.keyUserData);
    } else {
      await _prefs.setString(AppConstants.keyUserData, data);
    }
  }

  // --- Theme ---
  String get themeMode => _prefs.getString(AppConstants.keyThemeMode) ?? 'system';

  Future<void> setThemeMode(String mode) =>
      _prefs.setString(AppConstants.keyThemeMode, mode);

  // --- Cache ---
  Future<void> cachePrograms(List<Map<String, dynamic>> programs) =>
      _prefs.setString(
        AppConstants.keyCachedPrograms,
        jsonEncode(programs),
      );

  List<Map<String, dynamic>>? get cachedPrograms {
    final data = _prefs.getString(AppConstants.keyCachedPrograms);
    if (data == null) return null;
    return List<Map<String, dynamic>>.from(jsonDecode(data) as List);
  }

  Future<void> cacheExperts(List<Map<String, dynamic>> experts) =>
      _prefs.setString(
        AppConstants.keyCachedExperts,
        jsonEncode(experts),
      );

  List<Map<String, dynamic>>? get cachedExperts {
    final data = _prefs.getString(AppConstants.keyCachedExperts);
    if (data == null) return null;
    return List<Map<String, dynamic>>.from(jsonDecode(data) as List);
  }

  Future<void> clearAll() => _prefs.clear();
}
