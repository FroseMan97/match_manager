import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/presentation/blocs/match/match_bloc.dart';
import 'package:match_manager/presentation/blocs/match/match_event.dart';
import 'package:match_manager/presentation/blocs/match/match_state.dart';
import 'package:match_manager/presentation/blocs/matches/matches_state.dart';
import 'package:match_manager/presentation/widgets/badge.dart';
import 'package:match_manager/presentation/widgets/custom_image.dart';
import 'package:match_manager/utils/refresh_physics.dart';

import '../../styles.dart';

class MatchScreen extends StatelessWidget {
  final MatchBloc matchBloc;

  MatchScreen(this.matchBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          physics: RefreshScrollPhysics(),
          slivers: <Widget>[
            _buildAppbar(),
            _buildRefreshIndicator(),
            BlocBuilder(
              bloc: matchBloc,
              builder: (context, state) {
                if (state is LoadedMatchState) {
                  final match = state?.matchModel;
                  final requests = state?.requests;
                  final matchName = match?.matchName;
                  final matchPhoto = match?.matchPhoto;
                  final matchDescription = match?.matchDescription;
                  final matchDateTime = match?.matchDateTime;
                  final matchCollectionDateTime = match?.matchColletionDateTime;
                  final matchStatus = match?.matchStatus;
                  final workers = state?.workers;
                  return _buildBody(
                    matchName: matchName,
                    matchPhoto: matchPhoto,
                    matchDateTime: matchDateTime,
                    matchCollectionDateTime: matchCollectionDateTime,
                    matchDescription: matchDescription,
                    matchStatus: matchStatus,
                    workers: workers,
                    requests: requests,
                  );
                }
                return _buildLoading();
              },
            )
          ],
        ),
      ),
    );
  }

  _buildRefreshIndicator() {
    return CupertinoSliverRefreshControl(
      refreshIndicatorExtent: 80,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        matchBloc.add(LoadMatchEvent());
      },
    );
  }

  _buildAppbar() {
    return SliverAppBar(
      backgroundColor: CustomStyles.appBarColor,
      title: Text('Подробно о матче'),
      pinned: true,
    );
  }

  _buildLoading() {
    return SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _buildBody(
      {@required String matchPhoto,
      @required String matchName,
      @required DateTime matchDateTime,
      @required DateTime matchCollectionDateTime,
      @required String matchDescription,
      @required List<UserModel> requests,
      @required List<UserModel> workers,
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
                      trailing: Text(
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
                      trailing: Text(
                        '${CustomStyles.defaultDateTimeFormat.format(matchDateTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text('Сбор'),
                      trailing: Text(
                        '${CustomStyles.defaultDateTimeFormat.format(matchCollectionDateTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
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
                  title: Text(matchDescription),
                ),
              ),
            ],
          ),
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
                      style: CustomStyles.drawerPersonName,
                    ),
                    backgroundColor: Colors.lightBlueAccent,
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
        });
  }
}
