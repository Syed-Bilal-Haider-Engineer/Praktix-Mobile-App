import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user.dart';
import 'providers.dart';

/// Authentication state and actions.
// an auth context with `user`, `login()`, `logout()`.
/// `AsyncValue<UserModel?>` handles loading/error/data states automatically.
class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  AuthNotifier(this._ref) : super(const AsyncValue.loading()) {
    _checkAuth();
  }

  final Ref _ref;

  Future<void> _checkAuth() async {
    try {
      final user = await _ref.read(authRepositoryProvider).getCurrentUser();
      final isAuth = _ref.read(authRepositoryProvider).isAuthenticated;
      state = AsyncValue.data(isAuth ? user : null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user =
          await _ref.read(authRepositoryProvider).login(email, password);
      state = AsyncValue.data(user);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _ref
          .read(authRepositoryProvider)
          .register(name, email, password);
      state = AsyncValue.data(user);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await _ref.read(authRepositoryProvider).forgotPassword(email);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    await _ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref);
});
