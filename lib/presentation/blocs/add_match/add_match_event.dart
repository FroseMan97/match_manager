abstract class AddMatchEvent {}

class SetMatchInfoEvent extends AddMatchEvent {
  final String matchName;
  final String matchDate;
  final String matchCollectionDateTime;
  final String matchPhoto;
  final String matchDescription;

  SetMatchInfoEvent({
    this.matchDescription,
    this.matchName,
    this.matchPhoto,
    this.matchDate,
    this.matchCollectionDateTime,
  });
}
