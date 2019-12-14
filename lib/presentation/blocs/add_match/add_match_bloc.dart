import 'package:bloc/bloc.dart';
import 'package:match_manager/presentation/blocs/add_match/add_match_event.dart';
import 'package:match_manager/presentation/blocs/add_match/add_match_state.dart';

class AddMatchBloc extends Bloc<AddMatchEvent, SettedMatchState> {
  @override
  SettedMatchState get initialState => SettedMatchState();

  @override
  Stream<SettedMatchState> mapEventToState(AddMatchEvent event) async* {
    if(event is SetMatchInfoEvent) {
      yield SettedMatchState.fromCurrentState(
        currentState: state,
        matchCollectionDateTime: DateTime.tryParse(event.matchCollectionDateTime ?? ''),
        matchDate: DateTime.tryParse(event.matchDate ?? ''),
        matchName: event.matchName,
        matchPhoto: event.matchPhoto,
        matchDescription: event.matchDescription,
      );
    }
  }
  
}