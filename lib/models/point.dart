class AccountPoints {
  final int totalPoints;
  final double cashEquivalent;
  final DateTime date;

  AccountPoints({
    required this.totalPoints,
    required this.cashEquivalent,
    required this.date,
  });

  factory AccountPoints.fromJson(Map<String, dynamic> json) {
    return AccountPoints(
      totalPoints: json['totalPoints'] ?? 0,
      cashEquivalent: (json['cashEquivalent'] ?? 0).toDouble(),
      date: json.containsKey('date') ? DateTime.parse(json['date']) : DateTime.now(), 
    );
  }

  bool get isEmpty => totalPoints == 0;
  bool get isNotEmpty => totalPoints > 0; // Optional, for convenience

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'cashEquivalent': cashEquivalent,
      'date': date.toIso8601String(),
    };
  }
}
