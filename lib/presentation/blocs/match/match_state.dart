import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/data/models/user_model.dart';

abstract class MatchState {}

class LoadingMatchState extends MatchState {}

class LoadedMatchState extends MatchState {
  final MatchModel matchModel;
  final List<UserModel> requests;
  final List<UserModel> workers;

  LoadedMatchState(this.matchModel, this.requests, this.workers);

}

class ErrorMatchState extends MatchState{ 
  final String error;
  ErrorMatchState(this.error);
}

class EmptyMatchState extends MatchState{}



