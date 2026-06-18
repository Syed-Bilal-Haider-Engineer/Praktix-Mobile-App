class Workshop {
  const Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.speaker,
    required this.imageUrl,
    required this.isOnline,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String speaker;
  final String imageUrl;
  final bool isOnline;

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      speaker: json['speaker'] as String,
      imageUrl: json['imageUrl'] as String,
      isOnline: json['isOnline'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'time': time,
        'speaker': speaker,
        'imageUrl': imageUrl,
        'isOnline': isOnline,
      };
}
