class AuthResponseModel {
  String token;
  int id;

  AuthResponseModel({required this.token, required this.id});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(token: json['token'] ?? '', id: json['id'] ?? 0);
  }
}
