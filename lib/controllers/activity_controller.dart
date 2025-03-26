
import 'package:binclan/models/activity_model.dart';
import 'package:binclan/services/api_service.dart';

class ActivityController {
  final ApiService _apiService = ApiService();

  Future<List<Activity>> fetchActivities() {
    return _apiService.fetchActivities();
  }
}
