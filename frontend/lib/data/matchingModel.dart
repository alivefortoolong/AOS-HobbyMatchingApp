class MatchingModel {
  int id;
  String nom;
  String prenom;
  int age;
  String ville;
  String sexe;
  List<String> hobbies;

  MatchingModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.age,
    required this.ville,
    required this.sexe,
    required this.hobbies,
  });

  factory MatchingModel.fromJson(Map<String, dynamic> json) {
    return MatchingModel(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      age: json['age'] ?? 0,
      ville: json['ville'] ?? '',
      sexe: json['sexe'] ?? '',
      hobbies: List<String>.from(json['hobbies'] ?? []),
    );
  }
}
