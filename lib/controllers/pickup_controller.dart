import 'package:binclan/models/pickup_model.dart';
import 'package:binclan/services/api_service.dart';

class ShchedulehistoryController {
  final ApiService _apiService = ApiService();

  Future<List<PickupModel>> fetchScheduledHistory() {
    return _apiService.fetchPickupHistory();


  }
}