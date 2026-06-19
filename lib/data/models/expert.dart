class Expert {
  const Expert({
    required this.id,
    required this.name,
    required this.title,
    required this.specialization,
    required this.bio,
    required this.experience,
    required this.imageUrl,
    required this.programIds,
    this.company = '',
    this.isFollowing = false,
  });

  final String id;
  final String name;
  final String title;
  final String specialization;
  final String bio;
  final String experience;
  final String imageUrl;
  final List<String> programIds;
  final String company;
  final bool isFollowing;

  Expert copyWith({
    String? id,
    String? name,
    String? title,
    String? specialization,
    String? bio,
    String? experience,
    String? imageUrl,
    List<String>? programIds,
    String? company,
    bool? isFollowing,
  }) {
    return Expert(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      specialization: specialization ?? this.specialization,
      bio: bio ?? this.bio,
      experience: experience ?? this.experience,
      imageUrl: imageUrl ?? this.imageUrl,
      programIds: programIds ?? this.programIds,
      company: company ?? this.company,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      specialization: json['specialization'] as String,
      bio: json['bio'] as String,
      experience: json['experience'] as String,
      imageUrl: json['imageUrl'] as String,
      programIds: List<String>.from(json['programIds'] as List),
      company: json['company'] as String? ?? '',
      isFollowing: json['isFollowing'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'specialization': specialization,
        'bio': bio,
        'experience': experience,
        'imageUrl': imageUrl,
        'programIds': programIds,
        'company': company,
        'isFollowing': isFollowing,
      };
}
