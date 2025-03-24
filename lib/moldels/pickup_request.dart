import 'package:binclan/services/api_service.dart';

class PickupRequest {
  // This class has the submitPickupRequest function but doesn't have access to controllers

  Future<void> submitPickupRequest({
    required String userId, // Added userId as a required parameter
    required String date,
    required String? wasteType,
    required String estimatedWeight,
    required String? recurring,
  }) async {
    final apiService = ApiService();

    // Handle invalid estimatedWeight string gracefully
    double? parsedWeight = double.tryParse(estimatedWeight);
    if (parsedWeight == null) {
      throw Exception("Invalid estimated weight provided.");
    }

    // Passing the parameters correctly in a map
    await apiService.schedulePickup(
      userId: userId, // Pass userId from method argument
      date: date, // Use the date passed into the function
      wasteTypes: [wasteType ?? "defaultWasteType"], // Handle null values
      estimateWeight: parsedWeight, // Use the parsed weight value
      recurring: recurring == "true", // Convert string to bool if necessary
    );
  }
}
