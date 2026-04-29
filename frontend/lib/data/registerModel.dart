class RegisterModel {
  String nom;
  String prenom;
  String pwd;
  String sexe;
  String prefGender;
  int minAge;
  int maxAge;
  int? age;
  String ville;
  String link;
  String email;
  List<String> hobbies;

  RegisterModel({
    required this.nom,
    required this.prenom,
    required this.pwd,
    required this.sexe,
    required this.prefGender,
    required this.minAge,
    required this.maxAge,
    required this.age,
    required this.ville,
    required this.link,
    required this.email,
    required this.hobbies,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'pwd': pwd,
      'sexe': sexe,
      'prefGender': prefGender,
      'minAge': minAge,
      'maxAge': maxAge,
      'age': age,
      'ville': ville,
      'link': link,
      'email': email,
      'hobbies': hobbies,
    };
  }

  bool isComplete1() {
    return nom.isNotEmpty &&
        prenom.isNotEmpty &&
        pwd.isNotEmpty &&
        sexe.isNotEmpty &&
        age != Null &&
        ville.isNotEmpty &&
        link.isNotEmpty &&
        email.isNotEmpty;
  }
}
