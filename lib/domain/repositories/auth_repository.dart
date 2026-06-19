import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  bool get isAuthenticated;
}
