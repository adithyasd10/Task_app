import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF222831),
  cardColor: const Color(0xFF393E46),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFFDFD0B8))),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF948979),
  ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF6F0F0),
  cardColor: const Color(0xFFF2E2B1),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFF222831))),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFD5C7A3),
  ),
);
