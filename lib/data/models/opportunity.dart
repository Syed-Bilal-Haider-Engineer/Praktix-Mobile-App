class Opportunity {
  const Opportunity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.imageUrl,
    this.isSaved = false,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String description;
  final String imageUrl;
  final bool isSaved;

  Opportunity copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    String? type,
    String? description,
    String? imageUrl,
    bool? isSaved,
  }) {
    return Opportunity(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      type: type ?? this.type,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      isSaved: json['isSaved'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'company': company,
        'location': location,
        'type': type,
        'description': description,
        'imageUrl': imageUrl,
        'isSaved': isSaved,
      };
}
