import 'dart:convert';
import 'package:aos/data/matchesModel.dart';
import 'package:http/http.dart' as http;

class MatchesRemoteDataSource {
  Future<List<MatchesModel>> getMatches(int userId) async {
    final url = Uri.parse(
      'http://127.0.0.1:8002/api/matching/matches/$userId/',
    );

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) => MatchesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Matcheses: ${response.statusCode}');
    }
  }
}
