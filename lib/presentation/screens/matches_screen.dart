import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/datasources/users_local_datasource_impl.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/repositories/matches_repository_impl.dart';
import 'package:match_manager/data/repositories/users_repository_impl.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/presentation/blocs/match/match_bloc.dart';
import 'package:match_manager/presentation/blocs/matches/matches_bloc.dart';
import 'package:match_manager/presentation/blocs/matches/matches_event.dart';
import 'package:match_manager/presentation/blocs/matches/matches_state.dart';
import 'package:match_manager/presentation/widgets/drawer.dart';
import 'package:match_manager/presentation/widgets/match_snippet.dart';
import 'package:match_manager/utils/refresh_physics.dart';

import 'add_match_screen.dart';
import 'match_screen.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  MatchesBloc matchesBloc;

  @override
  void initState() {
    MatchesLocalDatasource localDatasource = MatchesLocalDatasource();
    MatchesRepository matchesRepository =
        MatchesRepositoryImpl(localDatasource);
    matchesBloc = MatchesBloc(matchesRepository: matchesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'ецус'.toUpperCase();
    return BlocProvider<MatchesBloc>(
      create: (context) => matchesBloc,
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        drawer: DrawerWidget(
          matches: true,
        ),
        body: Scrollbar(
          child: CustomScrollView(
            physics: RefreshScrollPhysics(),
            slivers: <Widget>[
              _buildAppbar(title),
              CupertinoSliverRefreshControl(
                refreshIndicatorExtent: 80,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  matchesBloc.add(LoadMatchesEvent());
                },
              ),
              BlocBuilder<MatchesBloc, MatchesState>(
                bloc: matchesBloc,
                builder: (context, state) {
                  if (state is LoadingMatchesState) {
                    return _buildLoadingWidget();
                  }
                  if (state is EmptyMatchesState) {
                    return _buildEmptyMatches();
                  }
                  if (state is ErrorMatchesState) {
                    return _buildErrorWidget(
                      state.errorMessage,
                    );
                  }
                  if (state is LoadedMatchesState) {
                    return _buildMatchesList(
                      state.matchesList,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddMatchScreen()),
      ),
      icon: Icon(Icons.add),
      label: Text(
        'Добавить матч',
      ),
    );
  }

  _buildAppbar(String title) {
    return SliverAppBar(
      title: Text(title),
      floating: true,
    );
  }

  _buildErrorWidget(String errorMessage) {
    return SliverFillRemaining(
      child: Center(child: Text(errorMessage)),
    );
  }

  _buildLoadingWidget() {
    return SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _buildEmptyMatches() {
    return SliverFillRemaining(
      child: Center(
        child: Text('Нет матчей'),
      ),
    );
  }

  _buildMatchesList(List<MatchModel> matchesList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final match = matchesList[i];
          return MatchSnippet(
            matchDescription: match.matchDescription,
            matchID: match.matchID,
            status: match.matchStatus,
            matchName: match?.matchName,
            matchDateTime: match?.matchDateTime,
            photo: match?.matchPhoto,
            matchCollectionDateTime: match?.matchColletionDateTime,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  final matchesDatasource = MatchesLocalDatasource();
                  final usersDatasource = UsersLocalDatasourceImpl();
                  final matchBloc = MatchBloc(
                    matchesRepository: MatchesRepositoryImpl(
                      matchesDatasource,
                    ),
                    usersRepository: UsersRepositoryImpl(
                      usersDatasource,
                    ),
                    matchID: match.matchID,
                  );
                  return BlocProvider<MatchBloc>(
                    create: (context) => matchBloc,
                    child: MatchScreen(),
                  );
                },
              ),
            ),
          );
        },
        addAutomaticKeepAlives: false,
        childCount: matchesList.length,
      ),
    );
  }
}
