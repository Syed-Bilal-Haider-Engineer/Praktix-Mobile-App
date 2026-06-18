class Program {
  const Program({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.certificateIncluded,
    required this.outcomes,
    required this.category,
    required this.imageUrl,
    this.enrolled = false,
    this.progress = 0.0,
  });

  final String id;
  final String title;
  final String description;
  final String duration;
  final bool certificateIncluded;
  final List<String> outcomes;
  final String category;
  final String imageUrl;
  final bool enrolled;
  final double progress;

  Program copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    bool? certificateIncluded,
    List<String>? outcomes,
    String? category,
    String? imageUrl,
    bool? enrolled,
    double? progress,
  }) {
    return Program(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      certificateIncluded: certificateIncluded ?? this.certificateIncluded,
      outcomes: outcomes ?? this.outcomes,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      enrolled: enrolled ?? this.enrolled,
      progress: progress ?? this.progress,
    );
  }

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      certificateIncluded: json['certificateIncluded'] as bool,
      outcomes: List<String>.from(json['outcomes'] as List),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      enrolled: json['enrolled'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'duration': duration,
        'certificateIncluded': certificateIncluded,
        'outcomes': outcomes,
        'category': category,
        'imageUrl': imageUrl,
        'enrolled': enrolled,
        'progress': progress,
      };
}
