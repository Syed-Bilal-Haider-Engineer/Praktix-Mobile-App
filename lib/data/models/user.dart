class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.enrolledProgramIds = const [],
    this.certificateIds = const [],
    this.savedOpportunityIds = const [],
    this.learningStreak = 0,
    this.totalXp = 0,
  });

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final List<String> enrolledProgramIds;
  final List<String> certificateIds;
  final List<String> savedOpportunityIds;
  final int learningStreak;
  final int totalXp;

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    List<String>? enrolledProgramIds,
    List<String>? certificateIds,
    List<String>? savedOpportunityIds,
    int? learningStreak,
    int? totalXp,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      enrolledProgramIds: enrolledProgramIds ?? this.enrolledProgramIds,
      certificateIds: certificateIds ?? this.certificateIds,
      savedOpportunityIds: savedOpportunityIds ?? this.savedOpportunityIds,
      learningStreak: learningStreak ?? this.learningStreak,
      totalXp: totalXp ?? this.totalXp,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      enrolledProgramIds:
          List<String>.from(json['enrolledProgramIds'] as List? ?? []),
      certificateIds: List<String>.from(json['certificateIds'] as List? ?? []),
      savedOpportunityIds:
          List<String>.from(json['savedOpportunityIds'] as List? ?? []),
      learningStreak: json['learningStreak'] as int? ?? 0,
      totalXp: json['totalXp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'enrolledProgramIds': enrolledProgramIds,
        'certificateIds': certificateIds,
        'savedOpportunityIds': savedOpportunityIds,
        'learningStreak': learningStreak,
        'totalXp': totalXp,
      };
}
