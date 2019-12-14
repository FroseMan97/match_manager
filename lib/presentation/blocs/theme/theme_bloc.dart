import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:match_manager/presentation/theme/custom_theme.dart';

import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => CustomTheme.lightTheme;

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is SetThemeEvent) {
      if (event.isDarkTheme) {
        yield CustomTheme.darkTheme;
      } else {
        yield CustomTheme.lightTheme;
      }
    }
  }
}
