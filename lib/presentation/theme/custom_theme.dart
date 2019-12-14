import 'package:flutter/material.dart';

class CustomTheme {
  static final lightTheme = ThemeData.light()
  .copyWith(
    primaryColor: Colors.lightBlueAccent,
    accentColor: Colors.lightBlueAccent,
    backgroundColor: Colors.white,
    unselectedWidgetColor: Colors.lightBlueAccent,
    colorScheme: ColorScheme.light(
      secondary: Colors.lightBlueAccent,
    ),
  );

  static final darkTheme = ThemeData.dark()
  .copyWith(
    accentColor: Colors.white,
    colorScheme: ColorScheme.light(
      secondary: Colors.white,
    ),
  );
}
