class Activity {
  final int id;
  final String userId;
  final String? user;
  final String title;
  final String description;
  final DateTime date;
  final DateTime createdAt;
  final String points;
  final int estimateWeight;

  Activity({
    required this.id,
    required this.userId,
    this.user,
    required this.title,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.estimateWeight,
    required this.points,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
  return Activity(
    id: (json['id'] is int) ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '') ?? 0, 
    userId: json['userId']?.toString() ?? 'Unknown',  
    user: json['user'], 
    title: json['title']?.toString() ?? 'No Title', 
    description: json['description']?.toString() ?? 'No Description',  
    estimateWeight: (json['estimateWeight'] is int) 
        ? json['estimateWeight'] as int 
        : int.tryParse(json['estimateWeight']?.toString() ?? '') ?? 0,
    points: json['points']?.toString() ?? '0', // Ensure points is always a string
    date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now() : DateTime.now(),
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now() : DateTime.now(),
  );
}



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'user': user,
      'title': title,
      'description': description,
      'estimateWeight': estimateWeight,
      'points': points.toString(),
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
