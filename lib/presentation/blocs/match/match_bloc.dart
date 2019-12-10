import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/domain/repositories/users_repository.dart';
import 'package:match_manager/presentation/blocs/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MatchBloc implements BaseBloc {
  final String matchID;
  final MatchesRepository matchesRepository;
  final UsersRepository usersRepository;

  MatchBloc(
      {@required this.matchID,
      @required this.matchesRepository,
      @required this.usersRepository}) {
    loadMatch();
  }

  final _matchSubject = BehaviorSubject<MatchModel>();
  Stream<MatchModel> get getMatch => _matchSubject.stream;

  final _requestsUsersSubject = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get getRequestsUser => _requestsUsersSubject.stream;

  final _workersUsersSubject = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get getWorkersUsers => _workersUsersSubject.stream;

  loadMatch() async {
    await matchesRepository.getMatch(matchID).then((MatchModel match) async {
      _matchSubject.add(match);
      if (match?.requests != null) {
        final requests = await _loadUsers(match.requests);
        _requestsUsersSubject.add(requests);
      }
      if(match?.workers != null) {
        final workers = await _loadUsers(match.workers);
        _workersUsersSubject.add(workers);
      }
    });
  }

  _loadUsers(List<String> users) async {
    final requestsUsers = await Future.wait(users.map((userID) => usersRepository.getUser(userID)));
    return requestsUsers;
  }

  @override
  void dispose() {
    _matchSubject.close();
    _requestsUsersSubject.close();
    _workersUsersSubject.close();
  }
}
