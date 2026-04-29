import 'dart:convert';
import 'package:aos/data/registerModel.dart';
import 'package:http/http.dart' as http;

class RegisterRemoteDataSource {
  Future<void> register(RegisterModel model) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/auth/register/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to register");
    }
  }
}
