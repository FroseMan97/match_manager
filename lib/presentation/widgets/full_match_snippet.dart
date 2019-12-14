import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/utils/formatter.dart';

import 'badge.dart';
import 'custom_image.dart';

class FullMatchSnippet extends StatelessWidget {
  final String matchPhoto;
  final String matchName;
  final DateTime matchDateTime;
  final DateTime matchCollectionDateTime;
  final String matchDescription;
  final List<UserModel> requests;
  final List<UserModel> workers;
  final String matchID;
  final MatchStatus matchStatus;

  FullMatchSnippet(
      {this.matchPhoto,
      this.matchName,
      this.matchDateTime,
      this.matchCollectionDateTime,
      this.matchDescription,
      this.requests,
      this.workers,
      this.matchID,
      this.matchStatus});

  @override
  Widget build(BuildContext context) {
    return _buildBody(
      matchCollectionDateTime: this.matchCollectionDateTime,
      matchDateTime: this.matchDateTime,
      matchDescription: this.matchDescription,
      matchID: this.matchID,
      matchName: this.matchName,
      matchPhoto: this.matchPhoto,
      matchStatus: this.matchStatus,
      requests: this.requests,
      workers: this.workers,
    );
  }

  _buildBody(
      {@required String matchPhoto,
      @required String matchName,
      @required DateTime matchDateTime,
      @required DateTime matchCollectionDateTime,
      @required String matchDescription,
      List<UserModel> requests,
      List<UserModel> workers,
      @required String matchID,
      @required MatchStatus matchStatus}) {
    final expansionTileStyle = TextStyle(fontSize: 16);
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          CustomImage(
            matchPhoto,
            height: 250,
          ),
          SizedBox(
            height: 4,
          ),
          ExpansionTile(
            title: Text(
              'Информация о матче',
              style: expansionTileStyle,
            ),
            trailing: Icon(Icons.info),
            initiallyExpanded: true,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Матч'),
                      trailing: SelectableText(
                        '$matchName',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text('Статус'),
                      trailing: BadgeWidget(
                        matchStatus: matchStatus,
                      ),
                    ),
                    ListTile(
                      title: Text('Начало'),
                      trailing: SelectableText(
                        matchDateTime != null
                            ? '${Formatter.defaultDateTimeFormat.format(matchDateTime)}'
                            : 'пока неизвестно',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text('Сбор'),
                      trailing: SelectableText(
                        matchCollectionDateTime != null
                            ? '${Formatter.defaultDateTimeFormat.format(matchCollectionDateTime)}'
                            : 'пока неизвестно',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          matchDescription != null
              ? ExpansionTile(
                  title: Text(
                    'Комментарий',
                    style: expansionTileStyle,
                  ),
                  trailing: Icon(Icons.comment),
                  initiallyExpanded: true,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: SelectableText(matchDescription),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          Visibility(
            visible: MatchStatusHelper.getRequestsVisible(matchStatus),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Заявки',
                    style: expansionTileStyle,
                  ),
                  CircleAvatar(
                    child: Text(
                      '${requests?.length ?? '0'}',
                    ),
                  )
                ],
              ),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: _buildUsersTile(requests))
              ],
            ),
          ),
          Visibility(
            visible: MatchStatusHelper.getWorkersVisible(matchStatus),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'На матч выходят',
                style: TextStyle(fontSize: 18),
              ),
              children: <Widget>[_buildUsersTile(workers)],
            ),
          )
        ],
      ),
    );
  }

  _buildUsersTile(List<UserModel> users) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: users?.length ?? 1,
      itemBuilder: (context, i) {
        if (users == null || users.isEmpty) {
          return Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Пока никого',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }
        final user = users[i];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              user.avatar,
            ),
          ),
          title: Text(
            user.fullName,
          ),
        );
      },
    );
  }
}
