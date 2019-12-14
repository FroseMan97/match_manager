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
  final DateTime matchCollectionDateTime;
  final MatchStatus status;

  MatchSnippet(
      {@required this.matchName,
      @required this.matchDateTime,
      @required this.matchCollectionDateTime,
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
              height: 220,
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            matchName,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: 18, letterSpacing: 0.25),
                          ),
                        ),
                      ),
                      BadgeWidget(
                        matchStatus: status,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  _buildInfoRow(
                    'Начало матча',
                    CustomStyles.defaultDateTimeFormat.format(matchDateTime),
                  ),
                  _buildInfoRow(
                    'Сбор',
                    CustomStyles.defaultDateTimeFormat.format(matchCollectionDateTime),
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

  Widget _buildInfoRow(String name, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '$data',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  _buildImage(String photo) {
    return Container(
        child: CustomImage(
      photo,
    ));
  }
}
