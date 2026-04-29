class User {
  int id;
  String nom;
  String prenom;
  String? sexe;
  int? age;
  String? ville;
  String? link;
  String? email;
  List<String> hobbies;
  List<int>? matches;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    this.sexe,
    this.age,
    this.ville,
    this.link,
    this.email,
    required this.hobbies,
    this.matches,
  });
}
