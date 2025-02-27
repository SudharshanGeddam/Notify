import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Notify/data/notifiers.dart';
import 'package:Notify/screens/login_screen.dart';
import 'package:Notify/screens/main_wrapper.dart';
import 'package:Notify/screens/offline_screen.dart';
import 'package:Notify/screens/register_screen.dart';
import 'package:Notify/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final bool hasInternet = await checkInternetConnection();
  final String initialRoute =
      hasInternet ? (await getLoginState() ? '/home' : '/') : '/offline';

  runApp(MyApp(initialRoute: initialRoute));
}

Future<bool> getLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != [ConnectivityResult.none];
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLightModeNotifier,
      builder: (context, isLightMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notify',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple,
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.purple,
              primaryContainer: Colors.purple.shade200,
              secondary: Colors.deepPurpleAccent,
              secondaryContainer: Colors.deepPurple.shade100,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple,
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.purple.shade900,
              foregroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.purple,
              primaryContainer: Colors.purple.shade700,
              secondary: Colors.deepPurpleAccent,
              secondaryContainer: Colors.deepPurple.shade700,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            ),
            useMaterial3: true,
          ),
          themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
          initialRoute: initialRoute,
          routes: {
            '/': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const MainWrapper(),
            '/sports': (context) => const MainWrapper(),
            '/exams': (context) => const MainWrapper(),
            'roadmaps': (context) => const MainWrapper(),
            '/offline': (context) => const OfflineScreen(),
          },
        );
      },
    );
  }
}
