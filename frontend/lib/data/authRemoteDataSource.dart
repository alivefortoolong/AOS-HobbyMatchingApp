import 'dart:convert';
import 'package:aos/data/authResponseModel.dart';
import 'package:aos/data/loginModel.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginModel model) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/auth/login/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['token']);

      return AuthResponseModel.fromJson(jsonResponse);
    } else {
      print("Login failed");
      return AuthResponseModel(token: "Failed", id: 0);
    }
  }
}
