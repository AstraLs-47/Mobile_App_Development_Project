import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gym_app/core/network/api_endpoints.dart';
import 'package:gym_app/features/auth/domain/user_role.dart';

class AuthService {
  String? _token;
  
  String? get token => _token;

  Future<UserRole?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Login Status: ${response.statusCode}');
      print('Login Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        final role = data['user']['role'];
        return role == 'admin' ? UserRole.admin : UserRole.user;
      }
      return null;
    } catch (e) {
      print('Login Error: $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final nameParts = name.trim().split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final body = jsonEncode({
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      });

      print('Signup URL: ${ApiEndpoints.register}');
      print('Signup Body: $body');

      final response = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Signup Status: ${response.statusCode}');
      print('Signup Response: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        return true;
      }
      return false;
    } catch (e) {
      print('Signup Error: $e');
      throw Exception('Signup failed: $e');
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.profile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      print('Profile Status: ${response.statusCode}');
      print('Profile Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['user'];
      }
      return null;
    } catch (e) {
      print('Profile Error: $e');
      throw Exception('Failed to get profile: $e');
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}/auth/signout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      print('Logout Status: ${response.statusCode}');
    } catch (e) {
      print('Logout Error: $e');
    }
  }

  Map<String, String> get authHeaders => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_token',
  };
}