// File: lib/data/api_service.dart

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notify/data/exam_details.dart';
import 'package:notify/data/latest_exams_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final http.Client _client = http.Client();
  static final String _baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'http://172.81.133.173:3000';

  // Registering the User
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
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['accessToken']);
      }
      return data;
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  // Login function users
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
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['accessToken']);
      }
      return data;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Fetching the user profile
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No access token found');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/auth/profile'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
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

  // Fetching the Jobs
  Future<List<JobDetails>?> fetchJobs() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No access token found');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/freejobalert/v1/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 120));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody is Map<String, dynamic> && jsonBody['data'] is List) {
          final List<dynamic> jobsRaw = jsonBody['data'];

          // Safely map only if each item is a Map
          return jobsRaw.whereType<Map<String, dynamic>>().map((item) {
            return JobDetails.fromJson(item);
          }).toList();
        } else {
          throw Exception('Unexpected data format from API');
        }
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      return null;
    }
    return null;
  }

  // Fetching the latest the Exam notifications
  Future<List<LatestExamsDetails>?> fetchLatestExams() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No access token found');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/freejobalert/v1/latest-edu'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 120));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> jsonData = data['data'];
          return jsonData
              .map((item) => LatestExamsDetails.fromJson(item))
              .toList();
        } else {
          throw Exception('API returned success = false');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching latest exams: $e');
      return null;
    }
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
