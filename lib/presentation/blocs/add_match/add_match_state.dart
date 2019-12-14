class SettedMatchState {
  final String matchName;
  final DateTime matchDate;
  final DateTime matchCollectionDateTime;
  final String matchPhoto;
  final String matchDescription;

  SettedMatchState({
    this.matchName = 'БЕЗ НАЗВАНИЯ',
    this.matchPhoto,
    this.matchDate,
    this.matchCollectionDateTime,
    this.matchDescription,
  });

  factory SettedMatchState.fromCurrentState({
    SettedMatchState currentState,
    String matchName,
    DateTime matchDate,
    DateTime matchCollectionDateTime,
    String matchPhoto,
    String matchDescription,
  }) {
    return SettedMatchState(
      matchDescription: matchDescription ?? currentState.matchDescription,
      matchCollectionDateTime:
          matchCollectionDateTime ?? currentState.matchCollectionDateTime,
      matchName: matchName ?? currentState.matchName,
      matchDate: matchDate ?? currentState.matchDate,
      matchPhoto: matchPhoto ?? currentState.matchPhoto,
    );
  }
}
