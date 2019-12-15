import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/domain/datasources/matches_datasource.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';

class MatchesRepositoryImpl extends MatchesRepository {
  final MatchesDatasource matchesDatasource;

  MatchesRepositoryImpl(this.matchesDatasource);

  final requestTimeOut = Duration(
    seconds: 5,
  );

  @override
  Future<List<MatchModel>> getMatches() {
    return matchesDatasource.getMatches().timeout(requestTimeOut);
  }

  @override
  Future<MatchModel> getMatch(String matchID) {
    return matchesDatasource.getMatch(matchID).timeout(requestTimeOut);
  }
}
