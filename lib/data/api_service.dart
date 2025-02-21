import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notify/data/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String baseurl =
      dotenv.env['API_URI'] ?? "http://142.93.219.77:5115";

  static Future<Map<String, dynamic>?> registerUser(String fullName, String dob,
      String phoneNo, String email, String password) async {
    final Uri url = Uri.parse("$baseurl/auth/register");

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": fullName,
          "dob": dob,
          "phoneNumber": phoneNo,
          "email": email,
          "password": password,
        }));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      await _saveToken(data["accessToken"]);
    }
    return data;
  }

  static Future<Map<String, dynamic>?> loginUSer(
      String email, String password) async {
    final Uri url = Uri.parse("$baseurl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await _saveToken(data["accessToken"]);
    }
    return data;
  }

  static Future<Map<String, dynamic>?> forgotPassword(String email) async {
    final Uri url = Uri.parse("$baseurl/auth/forgot-password");

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
        }));

    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>?> verifyPassword(String email, String code,
      String newPassword, String confirmPassword) async {
    final Uri url = Uri.parse("$baseurl/auth/reset-password");

    final response = await http.patch(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "code": code,
          "newPassword": newPassword,
          "passwordConfirm": confirmPassword,
        }));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      await _saveToken(data["accessToken"]);
    }
    return data;
  }

  Future<List<dynamic>> fetchJobs() async {
    try {
      final token = await _getToken();
      final response = await http.get(
          Uri.parse("$baseurl/freejobalert/v1/?page=1&limit=10"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];

        return jsonData.map<Job>((item) => Job.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load data$response");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

Future<void> _saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("access_token", token);
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("access_token");
}
