class Prefmodel {
  int id;
  String? town;
  String prefGender;
  int minAge;
  int maxAge;
  List<String> hobbies;

  Prefmodel({
    required this.id,
    this.town,
    required this.prefGender,
    required this.minAge,
    required this.maxAge,
    required this.hobbies,
  });

  factory Prefmodel.fromJson(Map<String, dynamic> json) {
    return Prefmodel(
      id: json['id'] ?? 0,
      town: json['ville'] ?? '',
      prefGender: json['prefGender'] ?? '',
      minAge: json['minAge'] ?? 0,
      maxAge: json['maxAge'] ?? 0,
      hobbies: List<String>.from(json['hobbies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'prefGender': prefGender,
      'minAge': minAge,
      'maxAge': maxAge,
      'hobbies': hobbies,
    };
  }
}
