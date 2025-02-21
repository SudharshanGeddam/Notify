import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notify/data/notifiers.dart';
import 'package:notify/screens/login_screen.dart';
import 'package:notify/screens/main_wrapper.dart';
import 'package:notify/screens/register_screen.dart';
import 'package:notify/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLightModeNotifier,
        builder: (context, isLightMode, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.white,
                    brightness:
                        isLightMode ? Brightness.light : Brightness.dark),
                useMaterial3: true,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => const WelcomeScreen(),
                '/login': (context) => const LoginScreen(),
                '/register': (context) => const RegisterScreen(),
                '/home': (context) => const MainWrapper(),
                '/sports': (context) => const MainWrapper(),
                '/exams': (context) => const MainWrapper(),
                'roadmaps': (context) => const MainWrapper(),
              });
        });
  }
}
