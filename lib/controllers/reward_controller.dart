import 'package:binclan/models/reward_model.dart';
import 'package:binclan/services/api_service.dart';

class RewardController {
  final ApiService _apiService = ApiService();

  Future<List<RewardModel>> fetchReward() { // ✅ Ensure correct return type
    return _apiService.fetchRewards();
  }
}