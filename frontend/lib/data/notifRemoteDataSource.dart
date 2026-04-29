import 'dart:convert';
import 'package:aos/data/notifModel.dart';
import 'package:http/http.dart' as http;

class NotifRemoteDataSource {
  Future<List<NotifModel>> getNotifications(int userId) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8003/api/notifications/$userId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id": userId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return (jsonResponse as List).map((e) => NotifModel.fromJson(e)).toList();
    } else {
      print("Failed to load notifications");
      return [];
    }
  }
}
