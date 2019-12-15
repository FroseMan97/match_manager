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
    this.matchName,
    this.matchDescription,
    this.matchDateTime,
    this.matchPhoto,
    this.requests,
    this.workers,
    this.matchColletionDateTime,
    this.matchStatus
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    if(json == null) {
      return null;
    }
    return MatchModel(
      matchID: json['matchID'],
      matchName: json['matchName'],
      matchDescription: json['matchDescription'],
      matchDateTime: DateTime.tryParse('${json['matchDateTime']}' ?? '')?.toLocal(),
      matchColletionDateTime: DateTime.tryParse('${json['matchCollectionDateTime']}' ?? '')?.toLocal(),
      matchPhoto: json['matchPhoto'],
      requests: json['requests'] != null ? json['requests'].cast<String>() : null,
      workers: json['workers'] != null ? json['workers'].cast<String>() : null,
      matchStatus: MatchStatus.values[json['matchStatus'] ?? 0]
    );
  }
}