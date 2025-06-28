import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notify/auth/login_screen.dart';
import 'package:notify/pages/profile_page.dart';
import 'package:notify/pages/settings_page.dart';
import 'package:notify/screens/exams_home.dart';
import 'package:notify/screens/home_page.dart';
import 'package:notify/screens/roadmaps.dart';
import 'package:notify/screens/sports_home.dart';
import 'package:notify/theme/app_themes.dart';
import 'package:notify/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize any necessary services here, such as Firebase or Hive
  await dotenv.load(fileName: ".env");
  final isLoggedIn = await getLoginState();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

// Saving login state
Future<bool> getLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Notify',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: isLoggedIn ? const HomePage() : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/exams': (context) => const ExamsHome(),
        '/sports': (context) => const SportsHome(),
        '/roadmaps': (context) => const Roadmaps(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
