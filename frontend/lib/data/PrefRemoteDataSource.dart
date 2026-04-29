import 'dart:convert';
import 'package:aos/data/PrefModel.dart';
import 'package:http/http.dart' as http;

class PrefRemoteDataSource {
  Future<Prefmodel> editPreferences(Prefmodel model) async {
    final response = await http.patch(
      Uri.parse("http://127.0.0.1:8001/api/users/preferences/edit/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return Prefmodel.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to update preferences");
    }
  }

  Future<Prefmodel> getPreferences(int userId) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8001/api/users/preferences/$userId"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return Prefmodel.fromJson(jsonResponse);
    } else {
      print("Failed to load preferences");
      return Prefmodel(
        id: 0,
        town: "",
        prefGender: "",
        minAge: 0,
        maxAge: 0,
        hobbies: [],
      );
    }
  }
}
