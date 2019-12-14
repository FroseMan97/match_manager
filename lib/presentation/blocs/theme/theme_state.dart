import 'package:flutter/material.dart';

abstract class ThemeState {}

class LightThemeState extends ThemeState {
  final ThemeData lightTheme = ThemeData.light();
}

class DarkThemeState extends ThemeState {
  final ThemeData darkTheme = ThemeData.dark();
}