import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/domain/datasources/matches_datasource.dart';

class MatchesLocalDatasourceImpl implements MatchesDatasource {
  Future<List<MatchModel>> getMatches() async {
    //await Future.delayed(Duration(seconds: 3));
    final jsonMap =
        jsonDecode(await rootBundle.loadString('mock/matches_mock.json'));
    final matchesList = jsonMap['matches'] as List;
    List<MatchModel> matchesModelList = List<MatchModel>();
    matchesList.forEach((item) {
      matchesModelList.add(MatchModel.fromJson(item));
    });
    return matchesModelList;
  }

  Future<MatchModel> getMatch(String matchID) async {
    final matches = await getMatches();
    return matches.firstWhere((match) => match.matchID == matchID, orElse: () => null);
  }
}
