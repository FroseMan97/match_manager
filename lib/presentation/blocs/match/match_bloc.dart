import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/domain/repositories/users_repository.dart';

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
      try {
        final match = await matchesRepository.getMatch(matchID);
        if (match == null) {
          yield EmptyMatchState();
        } else {
          var requests, workers;
          if (match?.requests != null) {
            requests = await _loadUsers(match.requests);
          }
          if (match?.workers != null) {
            workers = await _loadUsers(match.workers);
          }
          yield LoadedMatchState(match, requests, workers);
        }
      } catch (error) {
        yield ErrorMatchState(error.toString());
      }
    }
  }
}
