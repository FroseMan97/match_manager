import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/presentation/blocs/match/match_bloc.dart';
import 'package:match_manager/presentation/widgets/badge.dart';
import 'package:match_manager/presentation/widgets/custom_image.dart';
import 'package:match_manager/utils/refresh_physics.dart';

import '../../styles.dart';

class MatchScreen extends StatefulWidget {
  final MatchBloc matchBloc;

  MatchScreen({@required this.matchBloc});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  MatchBloc matchBloc;

  bool flag = false;

  @override
  void initState() {
    matchBloc = widget.matchBloc;
    super.initState();
  }

  @override
  void dispose() {
    matchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MatchModel>(
        stream: matchBloc.getMatch,
        builder: (context, snapshot) {
          final hasData = snapshot.hasData;
          final match = snapshot?.data;
          final matchName = match?.matchName;
          final matchPhoto = match?.matchPhoto;
          final matchDescription = match?.matchDescription;
          final matchDateTime = match?.matchDateTime;
          final matchCollectionDateTime = match?.matchColletionDateTime;
          final matchStatus = match?.matchStatus;
          return Scaffold(
            persistentFooterButtons: <Widget>[_buildFloatingActionButton()],
            body: CustomScrollView(
              physics: RefreshScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: CustomStyles.appBarColor,
                  title: Text(matchName ?? 'Загрузка...'),
                  pinned: true,
                ),
                CupertinoSliverRefreshControl(
                  refreshIndicatorExtent: 80,
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    matchBloc.loadMatch();
                  },
                ),
                hasData
                    ? _buildBody(
                        matchPhoto: matchPhoto,
                        matchDateTime: matchDateTime,
                        matchCollectionDateTime: matchCollectionDateTime,
                        matchDescription: matchDescription,
                        matchStatus: matchStatus)
                    : _buildLoading()
              ],
            ),
          );
        });
  }

  Widget _buildFloatingActionButton() {
    final onPressed = () => setState(() {
          flag = !flag;
        });
    final button1 = RaisedButton(
      splashColor: Colors.lightBlueAccent,
      color: Colors.green[500],
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text('Заявиться на матч'),
    );
    final button2 = RaisedButton(
      splashColor: Colors.lightBlueAccent,
      color: Colors.red[500],
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text('Отозвать заявку'),
    );
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 50,
        child: flag ? button1 : button2);
  }

  _buildLoading() {
    return SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _buildBody(
      {@required String matchPhoto,
      @required DateTime matchDateTime,
      @required DateTime matchCollectionDateTime,
      @required String matchDescription,
      @required MatchStatus matchStatus}) {
    return SliverList(
      delegate: SliverChildListDelegate([
        CustomImage(
          matchPhoto,
          height: 250,
        ),
        SizedBox(
          height: 4,
        ),
        ExpansionTile(
          initiallyExpanded: true,
          title: Text('Информация о матче'),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Статус'),
                    trailing: BadgeWidget(
                      matchStatus: matchStatus,
                    ),
                  ),
                  ListTile(
                    title: Text('Начало'),
                    trailing: Text(
                        '${CustomStyles.defaultDateTimeFormat.format(matchDateTime)}'),
                  ),
                  ListTile(
                    title: Text('Сбор'),
                    trailing: Text(
                        '${CustomStyles.defaultDateTimeFormat.format(matchCollectionDateTime)}'),
                  ),
                  ListTile(
                    title: Text(matchDescription),
                  )
                ],
              ),
            )
          ],
        ),
        StreamBuilder<List<UserModel>>(
            stream: matchBloc.getRequestsUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final requestsUsers = snapshot.data;
              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Заявки'),
                    CircleAvatar(
                      child: Text(
                        '${requestsUsers?.length ?? '0'}',
                        style: CustomStyles.drawerPersonName,
                      ),
                      backgroundColor: Colors.lightBlueAccent,
                    )
                  ],
                ),
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: _buildUsersTile(requestsUsers))
                ],
              );
            }),
        StreamBuilder<List<UserModel>>(
          stream: matchBloc.getWorkersUsers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final workers = snapshot.data;
            return ExpansionTile(
              title: Text('На матч выходят'),
              children: <Widget>[_buildUsersTile(workers)],
            );
          },
        )
      ]),
    );
  }

  _buildUsersTile(List<UserModel> users) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: users?.length,
        itemBuilder: (context, i) {
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
