import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notify/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            Text(
              'NOTIFY',
              style: TextStyle(fontSize: 24, letterSpacing: 35.0),
            ),
            Text(
              'GET NOTIFIED INSTANTLY',
              style: TextStyle(fontSize: 12, letterSpacing: 5.0),
            ),
            const SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
              style: FilledButton.styleFrom(
                maximumSize: Size(double.infinity, 40.0),
              ),
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
