// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../../core/models/user_model.dart';
import '../domain/user_role.dart';

class AuthService {
  // Prefix key for persisting each user's name keyed by their email
  static const String _keyUserPrefix = 'gym_user_name_';

  // In-memory session state
  static String currentUserName = 'User';
  static String currentUserEmail = 'user@example.com';

  // Onboarding data
  static String? selectedGoal;
  static String? activityLevel;
  static String? sex;
  static String? birthDate;
  static String? height;
  static String? weight;
  static String? goalWeight;

  /// Signs in a user. Looks up the persisted name for the given email so the
  /// correct name is always shown (not the hardcoded "John Doe" fallback).
  Future<UserRole> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@purepulse.com' && password == 'admin123') {
      currentUserName = 'Pulse Admin';
      currentUserEmail = email;
      return UserRole.admin;
    }

    // Look up the name that was saved when this user registered
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('$_keyUserPrefix$email');

    // Fallback: derive a friendly name from the email prefix
    currentUserName = savedName ?? _nameFromEmail(email);
    currentUserEmail = email;
    return UserRole.user;
  }

  /// Creates a new account and persists the chosen name against the email so
  /// it can be retrieved on every subsequent login.
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_keyUserPrefix$email', name);

    currentUserName = name;
    currentUserEmail = email;
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    currentUserName = 'User';
    currentUserEmail = 'user@example.com';
  }

  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return User(id: '1', name: currentUserName, email: currentUserEmail);
  }

  /// Converts an email like "john.doe@gmail.com" → "John Doe" as a graceful
  /// fallback when no registered name is found.
  static String _nameFromEmail(String email) {
    final local = email.split('@').first;
    return local
        .split(RegExp(r'[._]'))
        .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}
