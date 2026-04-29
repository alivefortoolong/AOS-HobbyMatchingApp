import 'package:aos/data/userModel.dart';

class MatchesModel {
  final int matchId;
  final String matchedAt;
  final UserModel user;

  MatchesModel({
    required this.matchId,
    required this.matchedAt,
    required this.user,
  });

  factory MatchesModel.fromJson(Map<String, dynamic> json) {
    return MatchesModel(
      matchId: json['match_id'],
      matchedAt: json['matched_at'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
