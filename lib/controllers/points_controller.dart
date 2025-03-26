import 'package:binclan/services/api_service.dart';
import 'package:binclan/models/point.dart'; // Import model

class PointsController {
  final ApiService _apiService = ApiService();

  Future<AccountPoints> fetchPoints() { // ✅ Ensure correct return type
    return _apiService.fetchPoints();
  }
}
