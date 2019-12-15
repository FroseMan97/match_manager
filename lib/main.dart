import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:match_manager/presentation/blocs/theme/theme_bloc.dart';
import 'package:match_manager/presentation/screens/news_screen.dart';

void main() async {
  initializeDateFormatting("ru_RU").then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: NewsScreen()
              ),
            ),
          );
        },
      ),
    );
  }
}
