import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/presentation/blocs/base/base_bloc.dart';
import 'package:rxdart/subjects.dart';

class MatchesBloc implements BaseBloc {
  final MatchesRepository matchesRepository;

  MatchesBloc({@required this.matchesRepository}) {
    loadMatches();
  }

  final _matchesSubject = BehaviorSubject<List<MatchModel>>();
  Stream<List<MatchModel>> get getMatches => _matchesSubject.stream;
  final _loadingMatchesSubject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get getMatchesLoading => _loadingMatchesSubject.stream;

  loadMatches() async {
    _loadingMatchesSubject.add(true);
    try {
      await matchesRepository.getMatches().then((List<MatchModel> matches) {
        _matchesSubject.add(matches);
      }).timeout(Duration(seconds: 5));
    } catch (error) {
      _matchesSubject.addError(error?.toString());
    } finally {
      _loadingMatchesSubject.add(false);
    }
  }

  @override
  void dispose() {
    _matchesSubject.close();
    _loadingMatchesSubject.close();
  }
}
