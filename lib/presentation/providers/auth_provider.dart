import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/user_repository.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepository _userRepository;

  AuthNotifier(this._userRepository) : super(AuthState()) {
    _loadSavedUser();
  }

  static const String _userIdKey = 'current_user_id';

  Future<void> _loadSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_userIdKey);

    if (userId != null) {
      final user = await _userRepository.getUserById(userId);
      if (user != null) {
        state = state.copyWith(user: user);
      }
    }
  }

  Future<bool> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _userRepository.createUser(
        email: email,
        name: name,
        password: password,
      );

      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: '이미 사용 중인 이메일입니다.',
        );
        return false;
      }

      // Save user ID
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userIdKey, user.id);

      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '회원가입에 실패했습니다.',
      );
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _userRepository.loginUser(
        email: email,
        password: password,
      );

      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: '이메일 또는 비밀번호가 올바르지 않습니다.',
        );
        return false;
      }

      // Save user ID
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userIdKey, user.id);

      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '로그인에 실패했습니다.',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    state = AuthState();
  }

  Future<bool> updateProfile({
    required String name,
    String? profileImageUrl,
  }) async {
    if (state.user == null) return false;

    state = state.copyWith(isLoading: true);

    try {
      final updatedUser = state.user!.copyWith(
        name: name,
        profileImageUrl: profileImageUrl,
      );

      final success = await _userRepository.updateUser(updatedUser);

      if (success) {
        state = state.copyWith(user: updatedUser, isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (state.user == null) return false;

    state = state.copyWith(isLoading: true);

    try {
      final success = await _userRepository.updatePassword(
        userId: state.user!.id,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    if (state.user == null) return false;

    state = state.copyWith(isLoading: true);

    try {
      final success = await _userRepository.deleteUser(state.user!.id);

      if (success) {
        await signOut();
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthNotifier(userRepository);
});
