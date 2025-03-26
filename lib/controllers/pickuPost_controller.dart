import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:binclan/models/pickupPost_model.dart';

class WasteCollectionController {
  final String apiUrl = 'https://pay1.jetdev.life/api/pickup/schedule';

  Future<List<WasteCollection>> fetchWasteCollections() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => WasteCollection.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load waste collections');
    }
  }

  Future<void> createWasteCollection(WasteCollection wasteCollection) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(wasteCollection.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create waste collection');
    }
  }
}