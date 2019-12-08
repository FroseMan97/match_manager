import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';

class MatchesRepositoryImpl extends MatchesRepository {
  final MatchesLocalDatasource localDatasource;

  MatchesRepositoryImpl(this.localDatasource);

  @override
  Future<List<MatchModel>> getMatches() {
    return localDatasource.getMatches();
  }

  @override
  Future<MatchModel> getMatch(String matchID) {
    return localDatasource.getMatch(matchID);
  }
}
