import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/presentation/widgets/badge.dart';
import 'package:match_manager/presentation/widgets/custom_image.dart';
import 'package:match_manager/utils/formatter.dart';

class MatchSnippet extends StatelessWidget {
  final String photo;
  final Function onTap;
  final String matchName;
  final DateTime matchDateTime;
  final DateTime matchCollectionDateTime;
  final MatchStatus status;
  final String matchID;

  MatchSnippet(
      {this.matchName,
      this.matchDateTime,
      this.matchCollectionDateTime,
      this.photo,
      this.status,
      this.matchID,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: InkWell(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: '$photo + $matchID',
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
                              matchName.toUpperCase(),
                              overflow: TextOverflow.visible,
                              style:
                                  TextStyle(fontSize: 18, letterSpacing: 0.25),
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
                      child: Divider(),
                    ),
                    _buildInfoRow(
                      'Начало матча',
                      matchDateTime != null
                          ? Formatter.defaultDateTimeFormat
                              .format(matchDateTime)
                          : 'пока неизвестно',
                    ),
                    _buildInfoRow(
                      'Сбор',
                      matchCollectionDateTime != null
                          ? Formatter.defaultDateTimeFormat
                              .format(matchCollectionDateTime)
                          : 'пока неизвестно',
                    ),
                  ],
                ),
              )
            ],
          ),
          elevation: 4,
        ),
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
    return AspectRatio(
      aspectRatio: 8/3, 
      child: SizedBox.expand(
        child: CustomImage(
          '$photo',
        ),
      ),
    );
  }
}
