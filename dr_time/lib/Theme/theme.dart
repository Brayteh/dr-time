import 'package:flutter/material.dart';

class MyTheme {
  static final primaryColor = const Color.fromARGB(255, 138, 186, 226); // عدّل حسب اللون الذي تستخدمه

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto', // أو اسم الخط الذي تستخدمه
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 14, color: Colors.blue),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
