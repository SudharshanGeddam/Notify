import 'package:flutter/material.dart';
import 'package:Notify/pages/profile_page.dart';
import 'package:Notify/pages/settings_page.dart';
import 'package:Notify/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideNavDrawerView extends StatelessWidget {
  const SideNavDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(children: [
          DrawerHeader(
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/notify-logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _logout(context);
                            },
                            child: Text('Logout'),
                          )
                        ],
                      ));
            },
          )
        ]),
      ),
    );
  }
}

Future<void> _logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("access_token");

  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WelcomeScreen()),
    (route) => false,
  );
}
