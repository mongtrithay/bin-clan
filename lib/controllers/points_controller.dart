import 'package:binclan/models/point.dart';
import 'package:binclan/services/api_service.dart';

class PointsController {
  final ApiService _apiService = ApiService();

  Future<List<AccountPoints>> fetchPoints() async {
    try {
      return await _apiService.fetchPoints(); // Ensure this returns List<AccountPoints>
    } catch (e, stackTrace) {
      print("Error fetching points: $e");
      print(stackTrace);
      return []; // Return an empty list if an error occurs
    }
  }
}
