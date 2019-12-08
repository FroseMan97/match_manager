import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_status_model.dart';

class MatchModel {
  final String matchID;
  final String matchName;
  final String matchDescription;
  final DateTime matchDateTime;
  final DateTime matchColletionDateTime;
  final String matchPhoto;
  final List<String> requests;
  final List<String> workers;
  final MatchStatus matchStatus;

  MatchModel({
    @required this.matchID,
    @required this.matchName,
    @required this.matchDescription,
    @required this.matchDateTime,
    @required this.matchPhoto,
    @required this.requests,
    @required this.workers,
    @required this.matchColletionDateTime,
    @required this.matchStatus
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    if(json == null) {
      throw Exception('Бред - Матч не будет null');
    }
    return MatchModel(
      matchID: json['matchID'],
      matchName: json['matchName'],
      matchDescription: json['matchDescription'],
      matchDateTime: DateTime.tryParse(json['matchDateTime'] ?? '')?.toLocal(),
      matchColletionDateTime: DateTime.tryParse(json['matchCollectionDateTime'] ?? '')?.toLocal(),
      matchPhoto: json['matchPhoto'],
      requests: json['requests'].cast<String>(),
      workers: json['workers'].cast<String>(),
      matchStatus: MatchStatus.values[json['matchStatus'] ?? 0]
    );
  }
}