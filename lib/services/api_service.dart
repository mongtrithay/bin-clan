import 'dart:convert';
import 'package:binclan/models/activity_model.dart';
import 'package:binclan/models/point.dart';
import 'package:binclan/models/reward_model.dart';
import 'package:binclan/models/user_model.dart';
import 'package:binclan/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:binclan/models/pickup_model.dart';


class ApiService {
  static const String baseUrl = 'https://pay1.jetdev.life';
  final StorageService _storageService = StorageService();

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/login'),
      body: jsonEncode({'username': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      if (user.token != null) {
        await _storageService.saveToken(user.token!); // Save token
      }
      return user;
    }
    return null;
  }

  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/register'),
      body: jsonEncode(user.toJson()), // Includes password in the payload
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  Future<List<Activity>> fetchActivities({int limit = 20}) async {
    final token = await _storageService.getToken(); // Retrieve token
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/activity?limit=$limit'),
      headers: {'Authorization': 'Bearer $token'}, // Use token
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Activity.fromJson(json)).toList();
    }
    return [];
  }

  Future<AccountPoints> fetchPoints() async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/points'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print("📊 API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return AccountPoints.fromJson(jsonData); // ✅ Proper JSON parsing
    }

    throw Exception("Failed to fetch points");
  }


  Future<List<RewardModel>> fetchRewards() async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/reward/listReward'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print("📊 API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData
          .map((e) => RewardModel.fromJson(e))
          .toList(); // ✅ Convert list to model
    }

    throw Exception("Failed to fetch rewards");
  }

  Future<List<PickupModel>> fetchPickupHistory() async {
    final token = await _storageService.getToken(); // Retrieve token
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/pickup/history'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => PickupModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load pickup history");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
