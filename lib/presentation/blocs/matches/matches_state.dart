import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_model.dart';

abstract class MatchesState {}

class LoadedMatchesState extends MatchesState {
  final List<MatchModel> matchesList;

  LoadedMatchesState({@required this.matchesList});
}

class EmptyMatchesState extends MatchesState {}

class LoadingMatchesState extends MatchesState {}

class ErrorMatchesState extends MatchesState {
  final String errorMessage;

  ErrorMatchesState(this.errorMessage);
}