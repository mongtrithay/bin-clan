class AccountPoints {
  final int totalPoints;
  final double cashEquivalent;

  AccountPoints({
    required this.totalPoints,
    required this.cashEquivalent,
  });

  factory AccountPoints.fromJson(Map<String, dynamic> json) {
    return AccountPoints(
      totalPoints: json['totalPoints'] ?? 0,
      cashEquivalent: (json['cashEquivalent'] ?? 0).toDouble(), 
    );
  }

  bool get isEmpty => totalPoints == 0;
  bool get isNotEmpty => totalPoints > 0; // Optional, for convenience

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'cashEquivalent': cashEquivalent,
    };
  }
}
