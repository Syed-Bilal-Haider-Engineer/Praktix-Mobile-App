class Certificate {
  const Certificate({
    required this.id,
    required this.title,
    required this.programName,
    required this.issuedDate,
    required this.credentialId,
  });

  final String id;
  final String title;
  final String programName;
  final DateTime issuedDate;
  final String credentialId;

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] as String,
      title: json['title'] as String,
      programName: json['programName'] as String,
      issuedDate: DateTime.parse(json['issuedDate'] as String),
      credentialId: json['credentialId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'programName': programName,
        'issuedDate': issuedDate.toIso8601String(),
        'credentialId': credentialId,
      };
}
