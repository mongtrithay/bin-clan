class WasteCollection {
  final DateTime date;
  final List<String> wasteTypes;
  final double estimateWeight;
  final bool recurring;

  WasteCollection({
    required this.date,
    required this.wasteTypes,
    required this.estimateWeight,
    required this.recurring,
  });

  factory WasteCollection.fromJson(Map<String, dynamic> json) {
    return WasteCollection(
      date: DateTime.parse(json['date']),
      wasteTypes: List<String>.from(json['wasteTypes']),
      estimateWeight: (json['estimateWeight'] as num).toDouble(),
      recurring: json['recurring'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'wasteTypes': wasteTypes,
      'estimateWeight': estimateWeight,
      'recurring': recurring,
    };
  }
}