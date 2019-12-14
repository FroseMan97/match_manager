import 'package:flutter/cupertino.dart';

abstract class ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  bool isDarkTheme;
  SetThemeEvent({
    this.isDarkTheme = false,
  });
}
