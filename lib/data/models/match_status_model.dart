enum MatchStatus {
  anons,
  requestOpen,
  requestClose,
  work,
  end
}

class MatchStatusHelper {
  static String getStatusString(MatchStatus status) {
    switch(status){
      case MatchStatus.anons:
        return 'Анонсирован';
      case MatchStatus.requestOpen:
        return 'Заявка открыта';
      case MatchStatus.requestClose:
        return 'Заявка закрыта';
      case MatchStatus.work:
        return 'Выход на матч';
      case MatchStatus.end:
        return 'Матч завершен';
      default:
        return 'Не определенный';
    }
  }
}