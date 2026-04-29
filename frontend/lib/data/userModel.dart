class UserModel {
  final int id;
  final int userId;
  final String nom;
  final String prenom;
  final String sexe;
  final int age;
  final String ville;
  final String link;
  final List<String> hobbies;

  UserModel({
    required this.id,
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.age,
    required this.ville,
    required this.link,
    required this.hobbies,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userId: json['user_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      sexe: json['sexe'],
      age: json['age'],
      ville: json['ville'],
      link: json['link'],
      hobbies: List<String>.from(json['hobbies']),
    );
  }
}
