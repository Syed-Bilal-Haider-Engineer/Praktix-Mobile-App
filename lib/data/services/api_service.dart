import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../datasources/mock/mock_data.dart';


/// ```
class ApiService {
  ApiService({String? baseUrl})
      : baseUrl = baseUrl ?? 'https://api.praktix.hopn.eu/v1';

  final String baseUrl;

  /// Simulates network delay — remove when using real API.
  Future<void> _simulateDelay() async {
    await Future<void>.delayed(AppConstants.mockApiDelay);
  }

  Future<List<Map<String, dynamic>>> getPrograms() async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/programs');
    return MockData.programs.map((p) => p.toJson()).toList();
  }

  Future<Map<String, dynamic>?> getProgram(String id) async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/programs/$id');
    try {
      return MockData.programs.firstWhere((p) => p.id == id).toJson();
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getExperts() async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/experts');
    return MockData.experts.map((e) => e.toJson()).toList();
  }

  Future<Map<String, dynamic>?> getExpert(String id) async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/experts/$id');
    try {
      return MockData.experts.firstWhere((e) => e.id == id).toJson();
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWorkshops() async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/workshops');
    return MockData.workshops.map((w) => w.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> getOpportunities() async {
    await _simulateDelay();
    debugPrint('[ApiService] GET $baseUrl/opportunities');
    return MockData.opportunities.map((o) => o.toJson()).toList();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    await _simulateDelay();
    debugPrint('[ApiService] POST $baseUrl/auth/login');
    if (email.isNotEmpty && password.length >= 6) {
      final displayName = StringExtensions.nameFromEmail(email);
      return {
        'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': MockData.mockUser
            .copyWith(name: displayName, email: email)
            .toJson(),
      };
    }
    throw Exception('Invalid email or password');
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    await _simulateDelay();
    debugPrint('[ApiService] POST $baseUrl/auth/register');
    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      return {
        'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': MockData.mockUser.copyWith(name: name, email: email).toJson(),
      };
    }
    throw Exception('Registration failed. Please check your inputs.');
  }

  Future<void> forgotPassword(String email) async {
    await _simulateDelay();
    debugPrint('[ApiService] POST $baseUrl/auth/forgot-password');
    if (!email.contains('@')) {
      throw Exception('Invalid email address');
    }
  }

  Future<String> getAiResponse(String question) async {
    await _simulateDelay();
    debugPrint('[ApiService] POST $baseUrl/ai/chat');
    return MockData.getAiResponse(question);
  }

  Future<Map<String, dynamic>> applyToProgram(String programId) async {
    await _simulateDelay();
    debugPrint('[ApiService] POST $baseUrl/programs/$programId/apply');
    return {'success': true, 'message': 'Application submitted successfully!'};
  }

  /// Utility to encode/decode JSON for caching.
  static String encodeJson(dynamic data) => jsonEncode(data);
  static dynamic decodeJson(String data) => jsonDecode(data);
}
