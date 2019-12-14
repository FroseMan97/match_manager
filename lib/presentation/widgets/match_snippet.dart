import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/presentation/widgets/base_snippet.dart';
import 'package:match_manager/utils/formatter.dart';

import 'badge.dart';

class MatchSnippet extends StatelessWidget {
  final String photo;
  final Function onTap;
  final String matchName;
  final DateTime matchDateTime;
  final DateTime matchCollectionDateTime;
  final MatchStatus status;
  final String matchID;
  final String matchDescription;

  MatchSnippet(
      {this.matchName,
      this.matchDateTime,
      this.matchCollectionDateTime,
      this.photo,
      this.status,
      this.matchID,
      this.matchDescription,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return BaseSnippet(
      photo: photo,
      onTap: onTap,
      needPhoto: true,
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
                    matchName?.toUpperCase() ?? 'БЕЗ НАЗВАНИЯ',
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
          matchDescription != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SelectableText(
                    matchDescription,
                    maxLines: 1,
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          _buildInfoRow(
            'Начало матча',
            matchDateTime != null
                ? Formatter.defaultDateTimeFormat.format(matchDateTime)
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
    );
  }

  Widget _buildInfoRow(String name, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SelectableText(
            name,
            style: TextStyle(fontSize: 16),
          ),
          SelectableText(
            '$data',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
