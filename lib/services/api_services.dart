import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:binclan/services/storage_service.dart';

class ApiService {
  final String baseUrl = 'https://pay1.jetdev.life/api/pickup';
    final StorageService _storageService = StorageService();
 // Replace with actual API URL

  // Method to schedule pickup
  Future<void> schedulePickup({
    required String userId,
    required String date,
    required List<String> wasteTypes,
    required double estimateWeight,
    required bool recurring,
  }) async {
    final url = Uri.parse('$baseUrl/schedule');
    final token = await _storageService.getToken(); // Retrieve token
    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> requestBody = {
      "userId": userId,
      "date": date,
      "wasteTypes": wasteTypes,
      "estimateWeight": estimateWeight,
      "recurring": recurring,
    };


    final response = await http.post(
      url,
      headers: {  "Content-Type": "application/json",
        'Authorization': 'Bearer $token'},
      body: jsonEncode(requestBody),
    );
    

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to schedule pickup: ${response.body}");
    }
  }

  // New method to get scheduled pickups
  Future<List<dynamic>> getScheduledPickups() async {
    final url = Uri.parse('$baseUrl/scheduled');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch scheduled pickups: ${response.body}");
    }
  }
}
