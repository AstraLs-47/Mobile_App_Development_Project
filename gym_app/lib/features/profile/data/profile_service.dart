// Project imports:
import '../../../../core/models/user_model.dart';
import '../../../auth/data/auth_service.dart';

class ProfileService {
  final AuthService _auth = AuthService();

  Future<User?> fetchProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return _auth.getCurrentUser();
  }

  Future<void> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Implementation for updating profile
  }
}
