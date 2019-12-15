import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/domain/datasources/matches_datasource.dart';

class MatchesFirestoreDatasourceImpl implements MatchesDatasource {
  Firestore _firestore;
  String _matchCollectionName = 'matches';

  MatchesFirestoreDatasourceImpl() {
    _firestore = Firestore.instance;
  }

  @override
  Future<MatchModel> getMatch(String matchID) async {
    final document = await _firestore
        .collection(_matchCollectionName)
        .document(matchID)
        .get();
    return MatchModel.fromJson(document.data);
  }

  @override
  Future<List<MatchModel>> getMatches() async {
    final documents =
        await _firestore.collection(_matchCollectionName).getDocuments();
    final List<MatchModel> matchesList =
        //TODO нужны мапперы
        //documents.documents.map((match) => MatchModel.fromJson(match.data)).toList();
        documents.documents.map(
      (match) {
        final matchID = match.documentID;
        final json = match.data;
        return MatchModel(
            matchID: matchID,
            matchName: json['matchName'],
            matchDescription: json['matchDescription'],
            matchDateTime:
                DateTime.tryParse('${json['matchDateTime']}' ?? '')?.toLocal(),
            matchColletionDateTime:
                DateTime.tryParse('${json['matchCollectionDateTime']}' ?? '')
                    ?.toLocal(),
            matchPhoto: json['matchPhoto'],
            requests: json['requests'] != null
                ? json['requests'].cast<String>()
                : null,
            workers:
                json['workers'] != null ? json['workers'].cast<String>() : null,
            matchStatus: MatchStatus.values[json['matchStatus'] ?? 0]);
      },
    ).toList();
    return matchesList;
  }
}
