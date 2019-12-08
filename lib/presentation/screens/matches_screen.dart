import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/datasources/users_local_datasource_impl.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/repositories/matches_repository_impl.dart';
import 'package:match_manager/data/repositories/users_repository_impl.dart';
import 'package:match_manager/styles.dart';
import 'package:match_manager/presentation/blocs/match_bloc.dart';
import 'package:match_manager/presentation/blocs/matches_bloc.dart';
import 'package:match_manager/presentation/widgets/match_snippet.dart';
import 'package:match_manager/utils/refresh_physics.dart';

import 'match_screen.dart';

class MatchesScreen extends StatefulWidget {
  final Widget drawer;
  final MatchesBloc matchesBloc;

  MatchesScreen({@required this.drawer, @required this.matchesBloc});

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  MatchesBloc matchesBloc;

  @override
  void initState() {
    matchesBloc = widget.matchesBloc;
    super.initState();
  }

  @override
  void dispose() {
    matchesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'ецус'.toUpperCase();
    return Scaffold(
      drawer: widget.drawer,
      body: CustomScrollView(
        physics: RefreshScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: CustomStyles.appBarColor,
            title: Text(title),
            floating: true,
          ),
          CupertinoSliverRefreshControl(
            refreshIndicatorExtent: 80,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              matchesBloc.loadMatches();
            },
          ),
          StreamBuilder<bool>(
            stream: matchesBloc.getMatchesLoading,
            builder: (context, snapshot) {
              return StreamBuilder<List<MatchModel>>(
                stream: matchesBloc.getMatches,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final matches = snapshot.data;
                    if (matches == null || matches.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text('Нет матчей'),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, i) {
                        final match = matches[i];
                        return MatchSnippet(
                            status: match.matchStatus,
                            matchName: match?.matchName,
                            matchDateTime: match?.matchDateTime,
                            photo: match?.matchPhoto,
                            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) {
                                  final matchesDatasource =MatchesLocalDatasource();
                                  final usersDatasource = UsersLocalDatasourceImpl();
                                  return MatchScreen(
                                    matchBloc: MatchBloc(
                                      matchesRepository: MatchesRepositoryImpl(matchesDatasource), 
                                      usersRepository: UsersRepositoryImpl(usersDatasource),
                                      matchID: match.matchID
                                    ),
                                  );
                                })));
                      },
                          addAutomaticKeepAlives: false,
                          childCount: snapshot.data.length),
                    );
                  }
                  if(snapshot.hasError){
                    return SliverFillRemaining(
                    child: Center(child: Text(snapshot.error)),
                  );
                  }
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
