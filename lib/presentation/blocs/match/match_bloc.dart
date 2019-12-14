import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/domain/repositories/users_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'match_event.dart';
import 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final String matchID;
  final MatchesRepository matchesRepository;
  final UsersRepository usersRepository;

  MatchBloc(
      {@required this.matchID,
      @required this.matchesRepository,
      @required this.usersRepository}) {
    add(LoadMatchEvent());
  }

  _loadUsers(List<String> users) async {
    final requestsUsers = await Future.wait(
        users.map((userID) => usersRepository.getUser(userID)));
    return requestsUsers;
  }

  @override
  get initialState => LoadingMatchState();

  @override
  Stream<MatchState> mapEventToState(MatchEvent event) async* {
    if (event is LoadMatchEvent) {
      yield LoadingMatchState();
      final match = await matchesRepository.getMatch(matchID);
      var requests, workers;
      if (match?.requests != null) {
         requests = await _loadUsers(match.requests);
      }
      if (match?.workers != null) {
         workers = await _loadUsers(match.workers);
      }
      yield LoadedMatchState(match, requests, workers);
    }
  }
}
