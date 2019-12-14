import 'package:flutter/material.dart';

class CustomTheme {

  static Color goldColor = Color(0xFFAC9261);

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.lightBlueAccent,
    accentColor: Colors.lightBlueAccent,
    backgroundColor: Colors.white,
    unselectedWidgetColor: Colors.lightBlueAccent,
    cursorColor: Colors.lightBlueAccent,
    dividerTheme: DividerThemeData(
      color: Colors.lightBlueAccent,
    ),
     buttonTheme: ButtonThemeData(
           buttonColor: Colors.lightBlueAccent,
           textTheme: ButtonTextTheme.normal
    ),
    colorScheme: ColorScheme.light(
      secondary: Colors.lightBlueAccent,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    accentTextTheme: TextTheme(
      title: TextStyle(
        color: goldColor,
      ),
    ),
    cursorColor: goldColor,
    accentColor: goldColor,
    colorScheme: ColorScheme.light(
      secondary: goldColor,
    ),
  );
}
