import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notify/data/exam_details.dart';
import 'package:notify/data/latest_exams_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final http.Client _client = http.Client();
  static final String _baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'http://172.81.133.173:3000/';

  static Future<Map<String, dynamic>?> registerUser(
    String fullName,
    String dob,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'fullName': fullName,
              'dob': dob,
              'phoneNumber': phoneNumber,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['accessToken']);
        return data;
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['accessToken']);
        return data;
      } else {
        throw Exception('Failed to login user');
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyPasswordReset(
    String email,
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/auth/reset-password'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'otp': otp,
              'newPassword': newPassword,
              'passwordConfirm': confirmPassword,
            }),
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['accessToken']);
        print('Password reset successful');
        return data;
      } else {
        throw Exception('Failed to verify password reset');
      }
    } catch (e) {
      print('Error during password reset verification: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No access token found');
      }
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/auth/profile'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        return data;
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<List<dynamic>?> fetchExams() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No access token found');
      }
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/freejobalert/v1/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        var jsonData = json.decode(response.body)['data'] as List<dynamic>;
        return jsonData.map((item) => ExamDetails.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch exams');
      }
    } catch (e) {
      print('Error fetching exams: $e');
      return null;
    }
  }

  Future<List<dynamic>?> fetchLatestExams() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No access token found');
      }
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/freejobalert/v1/latest-edu'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Check if the response is successful
      if (response.statusCode == 200 && data['success'] == true) {
        var jsonData = json.decode(response.body)['data'] as List<dynamic>;
        return jsonData
            .map((item) => LatestExamsDetails.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch exams');
      }
    } catch (e) {
      print('Error fetching exams: $e');
      return null;
    }
  }
}

// Function to save the token securely
Future<void> _saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', token);
}

// Function to retrieve the token securely
Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}
