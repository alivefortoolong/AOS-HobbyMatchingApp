class NotifModel {
  int id;
  String nom;
  String prenom;
  String message;

  NotifModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.message,
  });

  factory NotifModel.fromJson(Map<String, dynamic> json) {
    return NotifModel(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      message: json['msg'] ?? '',
    );
  }
}
