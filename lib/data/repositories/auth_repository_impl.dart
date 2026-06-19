import 'dart:convert';
import '../../data/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/mock/mock_data.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api, this._storage);

  final ApiService _api;
  final LocalStorageService _storage;
  UserModel? _currentUser;

  @override
  bool get isAuthenticated => _storage.authToken != null;

  @override
  Future<UserModel> login(String email, String password) async {
    UserModel? existingUser;
    final existingData = _storage.userData;
    if (existingData != null) {
      existingUser = UserModel.fromJson(
        jsonDecode(existingData) as Map<String, dynamic>,
      );
    }

    final result = await _api.login(email, password);
    await _storage.setAuthToken(result['token'] as String);
    var user = UserModel.fromJson(result['user'] as Map<String, dynamic>);

    if (existingUser != null &&
        existingUser.email.toLowerCase() == email.toLowerCase()) {
      user = user.copyWith(name: existingUser.name);
    }

    _currentUser = user;
    await _storage.setUserData(jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<UserModel> register(
    String name,
    String email,
    String password,
  ) async {
    final result = await _api.register(name, email, password);
    await _storage.setAuthToken(result['token'] as String);
    final user = UserModel.fromJson(result['user'] as Map<String, dynamic>);
    _currentUser = user;
    await _storage.setUserData(jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<void> forgotPassword(String email) => _api.forgotPassword(email);

  @override
  Future<void> logout() async {
    _currentUser = null;
    await _storage.setAuthToken(null);
    await _storage.setUserData(null);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;

    final data = _storage.userData;
    if (data != null) {
      _currentUser = UserModel.fromJson(
        jsonDecode(data) as Map<String, dynamic>,
      );
      return _currentUser;
    }

    if (isAuthenticated) return MockData.mockUser;
    return null;
  }
}
