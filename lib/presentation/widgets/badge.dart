import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_status_model.dart';

class BadgeWidget extends StatelessWidget {
  final MatchStatus matchStatus;

  BadgeWidget({@required this.matchStatus});

  @override
  Widget build(BuildContext context) {
    return getBadge(matchStatus);
  }

  Widget getBadge(MatchStatus matchStatus) {
    Color color = Colors.black;
    switch (matchStatus) {
      case MatchStatus.anons:
        color = Colors.lightBlueAccent;
        break;
      case MatchStatus.requestOpen:
        color = Colors.orange;
        break;
      case MatchStatus.requestClose:
        color = Colors.red;
        break;
      case MatchStatus.work:
        color = Colors.green;
        break;
      case MatchStatus.end:
        color = Colors.grey;
        break;
      default:
        color = Colors.yellow;
        break;
    }
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Text(
        MatchStatusHelper.getStatusString(matchStatus),
        style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.25,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            fontSize: 14),
      ),
    );
  }
}
