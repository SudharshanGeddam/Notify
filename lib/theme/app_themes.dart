import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  primaryColor: const Color.fromRGBO(2, 129, 255, 1),
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(56, 182, 255, 1),
    brightness: Brightness.light,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[500],
    hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  cardColor: Color.fromRGBO(210, 239, 255, 1),
  useMaterial3: true,
  fontFamily: 'Poppins',
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(56, 182, 255, 1),
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(56, 182, 255, 1),
    brightness: Brightness.dark,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color.fromARGB(255, 30, 30, 30),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.grey,
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: Color.fromRGBO(120, 127, 131, 1),
  useMaterial3: true,
  fontFamily: 'Poppins',
);
