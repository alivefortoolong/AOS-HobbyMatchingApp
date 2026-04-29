import 'dart:convert';
import 'package:aos/data/likeModel.dart';
import 'package:http/http.dart' as http;

class LikeRemoteDataSource {
  Future<void> sendLike(Likemodel model) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8002/api/matching/like/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['liked']);
      print(jsonResponse['matched'] ?? '');
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to send like");
    }
  }
}
