class ProfileModel {
  int id;
  String nom;
  String prenom;
  int age;
  String ville;
  String sexe;
  String link;
  List<String> hobbies;

  ProfileModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.age,
    required this.ville,
    required this.sexe,
    required this.link,
    required this.hobbies,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      age: json['age'] ?? 0,
      ville: json['ville'] ?? '',
      sexe: json['sexe'] ?? '',
      link: json['link'] ?? '',
      hobbies: List<String>.from(json['hobbies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'age': age,
      'ville': ville,
      'sexe': sexe,
      'link': link,
      'hobbies': hobbies,
    };
  }
}
