class PickupModel {
  final int id;
  final String userId;
  final String date;
  final List<String> wasteTypes;
  final double estimateWeight;
  final bool recurring;

  PickupModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.wasteTypes,
    required this.estimateWeight,
    required this.recurring,
  });

  factory PickupModel.fromJson(Map<String, dynamic> json) {
    return PickupModel(
      id: json['id'] ?? 0, // Provide a default value if null
      userId: json['userId'] ?? '',
      date: json['date'] ?? '',
      wasteTypes: (json['wasteTypes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      estimateWeight: json['estimateWeight']?.toDouble() ?? 0.0,
      recurring: json['recurring'] ?? false,
    );
  }

  // Fix the toJson() method to return a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'wasteTypes': wasteTypes,
      'estimateWeight': estimateWeight,
      'recurring': recurring,
    };
  }
}