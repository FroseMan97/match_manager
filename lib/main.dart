import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/repositories/matches_repository_impl.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/presentation/blocs/matches/matches_bloc.dart';
import 'presentation/screens/matches_screen.dart';
import 'presentation/widgets/drawer.dart';

void main() async {
  initializeDateFormatting("ru_RU").then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final drawer = DrawerWidget();
  @override
  Widget build(BuildContext context) {
    final MatchesLocalDatasource matchesLocalDatasource =
        MatchesLocalDatasource();
    final MatchesRepository matchesRepository =
        MatchesRepositoryImpl(matchesLocalDatasource);
    final MatchesBloc matchesBloc =
        MatchesBloc(matchesRepository: matchesRepository);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.lightBlueAccent,
        child: SafeArea(
            top: true,
            child: MatchesScreen(drawer: drawer, matchesBloc: matchesBloc)),
      ),
    );
  }
}
