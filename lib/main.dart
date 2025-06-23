import 'package:flutter/material.dart';
import 'package:notify/pages/profile_page.dart';
import 'package:notify/pages/settings_page.dart';
import 'package:notify/screens/exams_home.dart';
import 'package:notify/screens/home_page.dart';
import 'package:notify/screens/roadmaps.dart';
import 'package:notify/screens/sports_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notify',
      theme: ThemeData(
        // This is the theme of your application.
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(56, 182, 255, 1),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(56, 182, 255, 1),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        // Use the Poppins font family
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/exams': (context) => const ExamsHome(),
        '/sports': (context) => const SportsHome(),
        '/roadmaps': (context) => const Roadmaps(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
