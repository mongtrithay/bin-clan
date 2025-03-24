import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Method to schedule pickup
  Future<void> schedulePickup({
    required String userId,
    required String date,
    required List<String> wasteTypes,
    required double estimateWeight,
    required bool recurring,
  }) async {
    final url = Uri.parse('http://localhost:44113/api/pickup/schedule'); // Replace with actual API URL

    // Prepare the request body with the data
    Map<String, dynamic> requestBody = {
      "userId": userId, // Using the passed userId
      "date": date, // Using the passed date
      "wasteTypes": wasteTypes, // Using the passed list of waste types
      "estimateWeight": estimateWeight, // Using the passed estimated weight
      "recurring": recurring, // Using the passed recurring status
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to schedule pickup: ${response.body}");
    }
  }
}