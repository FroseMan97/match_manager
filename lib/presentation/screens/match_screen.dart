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
import 'package:match_manager/presentation/widgets/full_match_snippet.dart';
import 'package:match_manager/utils/formatter.dart';
import 'package:match_manager/utils/refresh_physics.dart';

class MatchScreen extends StatelessWidget {
  MatchBloc matchBloc;

  @override
  Widget build(BuildContext context) {
    matchBloc = BlocProvider.of<MatchBloc>(context);
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          physics: RefreshScrollPhysics(),
          slivers: <Widget>[
            _buildAppbar(),
            _buildRefreshIndicator(),
            BlocBuilder<MatchBloc, MatchState>(
              bloc: matchBloc,
              builder: (context, state) {
                if (state is LoadedMatchState) {
                  final match = state?.matchModel;
                  final matchID = match?.matchID;
                  final requests = state?.requests;
                  final matchName = match?.matchName;
                  final matchPhoto = match?.matchPhoto;
                  final matchDescription = match?.matchDescription;
                  final matchDateTime = match?.matchDateTime;
                  final matchCollectionDateTime = match?.matchColletionDateTime;
                  final matchStatus = match?.matchStatus;
                  final workers = state?.workers;
                  return FullMatchSnippet(
                    matchID: matchID,
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
      title: Text('Подробно о матче'),
      pinned: true,
      forceElevated: true,
    );
  }

  _buildLoading() {
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
