import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/presentation/widgets/badge.dart';
import 'package:match_manager/presentation/widgets/custom_image.dart';

import '../../styles.dart';

class MatchSnippet extends StatelessWidget {
  final String photo;
  final Function onTap;
  final String matchName;
  final DateTime matchDateTime;
  final MatchStatus status;

  MatchSnippet(
      {@required this.matchName,
      @required this.matchDateTime,
      @required this.photo,
      @required this.status,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              child: Container(
                child: _buildImage(photo),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        matchName,
                        style: TextStyle(fontSize: 18, letterSpacing: 0.25),
                      ),
                      BadgeWidget(
                        matchStatus: status,
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Начало матча',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${CustomStyles.defaultDateTimeFormat.format(matchDateTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        elevation: 4,
      ),
    );
  }

  _buildImage(String photo) {
    return Container(
        child: CustomImage(
      photo,
      color: Colors.grey[300],
      blendMode: BlendMode.darken,
    ));
  }
}
