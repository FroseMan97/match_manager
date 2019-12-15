import 'package:match_manager/data/models/match_model.dart';

abstract class MatchesDatasource {
  Future<List<MatchModel>> getMatches();

  Future<MatchModel> getMatch(String matchID);
}
