import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:match_manager/data/datasources/matches_local_datasource_impl.dart';
import 'package:match_manager/data/repositories/matches_repository_impl.dart';
import 'package:match_manager/domain/repositories/matches_repository.dart';
import 'package:match_manager/presentation/blocs/matches/matches_bloc.dart';
import 'package:match_manager/presentation/blocs/theme/theme_bloc.dart';
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
    final themeBloc = ThemeBloc();

    return BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: Container(
              child: SafeArea(
                top: true,
                child: BlocProvider<MatchesBloc>(
                  create: (context) => matchesBloc,
                  child: MatchesScreen(
                    drawer: drawer,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
