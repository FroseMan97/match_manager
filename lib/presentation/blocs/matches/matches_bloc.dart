import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/presentation/blocs/matches/matches_event.dart';
import 'package:match_manager/presentation/blocs/matches/matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final MatchesRepository matchesRepository;

  MatchesBloc({@required this.matchesRepository}) {
    add(LoadMatchesEvent());
  }

  @override
  MatchesState get initialState => LoadingMatchesState();

  @override
  Stream<MatchesState> mapEventToState(MatchesEvent event) async* {
    if (event is LoadMatchesEvent) {
      yield LoadingMatchesState();
      await Future.delayed(Duration(seconds: 2));
      
        final List<MatchModel> results =
            await matchesRepository.getMatches().timeout(
                  Duration(seconds: 5),
                );
        if (results == null || results.isEmpty) {
          yield EmptyMatchesState();
        }
        yield LoadedMatchesState(
          matchesList: results,
        );
      
    }
  }
}
