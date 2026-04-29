import 'dart:convert';
import 'package:aos/data/profileModel.dart';
import 'package:http/http.dart' as http;

class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(int userId) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8001/api/users/$userId"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return ProfileModel.fromJson(jsonResponse);
    } else {
      print("Failed to load profile");
      return ProfileModel(
        id: 0,
        nom: "",
        prenom: "",
        age: 0,
        ville: "",
        sexe: "",
        link: "",
        hobbies: [],
      );
    }
  }
}
