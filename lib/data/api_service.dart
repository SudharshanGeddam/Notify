import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notify/data/exams.dart';
import 'package:notify/data/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final http.Client client = http.Client();
  static final String baseurl =
      dotenv.env['API_URI'] ?? "http://142.93.219.77:5115";

  static Future<Map<String, dynamic>?> registerUser(String fullName, String dob,
      String phoneNo, String email, String password) async {
    final Uri url = Uri.parse("$baseurl/auth/register");

    try {
      final response = await client
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "fullName": fullName,
              "dob": dob,
              "phoneNumber": phoneNo,
              "email": email,
              "password": password,
            }),
          )
          .timeout(Duration(seconds: 60));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        await _saveToken(data["accessToken"]);
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> loginUSer(
      String email, String password) async {
    final Uri url = Uri.parse("$baseurl/auth/login");

    try {
      final response = await client
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "email": email,
              "password": password,
            }),
          )
          .timeout(Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await _saveToken(data["accessToken"]);
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> forgotPassword(String email) async {
    final Uri url = Uri.parse("$baseurl/auth/forgot-password");

    try {
      final response = await client
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "email": email,
            }),
          )
          .timeout(Duration(seconds: 60));

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyPassword(String email, String code,
      String newPassword, String confirmPassword) async {
    final Uri url = Uri.parse("$baseurl/auth/reset-password");

    try {
      final response = await client
          .patch(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "email": email,
              "code": code,
              "newPassword": newPassword,
              "passwordConfirm": confirmPassword,
            }),
          )
          .timeout(Duration(seconds: 60));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        await _saveToken(data["accessToken"]);
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> _getUserId() async {
    final token = await _getToken();
    if (token == null) {
      return null;
    }
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      String payload = parts[1];

      switch (payload.length % 4) {
        case 0:
          break;
        case 2:
          payload += "==";
          break;
        case 3:
          payload += "=";
          break;
        default:
          return null;
      }

      final decoded = utf8.decode(base64Url.decode(payload));
      final payloadMap = json.decode(decoded);
      if (payloadMap is Map<String, dynamic> &&
          payloadMap.containsKey("userId")) {
        return payloadMap["userId"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> getProfile() async {
    final userId = await _getUserId();
    if (userId == null) {
      return null;
    }

    final Uri uri =
        Uri.parse("$baseurl/auth/profile").replace(queryParameters: {
      'userId': userId,
    });

    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> fetchJobs() async {
    try {
      final token = await _getToken();
      final response =
          await client.get(Uri.parse("$baseurl/freejobalert/v1/"), headers: {
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

  Future<List<dynamic>> fetchExams() async {
    try {
      final token = await _getToken();
      final response = await client
          .get(Uri.parse("$baseurl/freejobalert/v1/latest-edu"), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];

        return jsonData.map<Exams>((item) => Exams.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load data $response");
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
