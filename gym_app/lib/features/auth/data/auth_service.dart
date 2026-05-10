// Project imports:
import '../../../core/models/user_model.dart';
import '../domain/user_role.dart';

class AuthService {
  // Mock session data
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
  
  // Empty Future methods for backend integration
  Future<UserRole> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // Implementation will go here
    if (email == 'admin@purepulse.com' && password == 'admin123') {
      currentUserName = 'Pulse Admin';
      currentUserEmail = email;
      return UserRole.admin;
    }
    currentUserName = 'John Doe';
    currentUserEmail = email;
    return UserRole.user;
  }

  Future<bool> signUp({required String name, required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    currentUserName = name;
    currentUserEmail = email;
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return User(id: '1', name: currentUserName, email: currentUserEmail);
  }
}
