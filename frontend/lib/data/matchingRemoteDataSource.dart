import 'dart:convert';
import 'package:aos/data/matchingModel.dart';
import 'package:http/http.dart' as http;

class MatchingRemoteDataSource {
  Future<List<MatchingModel>> getMatchings() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8001/api/users/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return (jsonResponse as List)
          .map((e) => MatchingModel.fromJson(e))
          .toList();
    } else {
      print("Failed to load matchings");
      return [];
    }
  }
}
