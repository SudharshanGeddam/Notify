import 'package:flutter/material.dart';
import 'package:notify/data/sports_data.dart';
import 'package:notify/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SportsHome extends StatefulWidget {
  const SportsHome({super.key});

  @override
  State<SportsHome> createState() => _SportsHomeState();
}

class _SportsHomeState extends State<SportsHome> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sports')),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isDark
                      ? 'assets/images/dark_bg.png'
                      : 'assets/images/auth_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: sportsAuthorities.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final authority = sportsAuthorities[index];
                  return ListTile(
                    title: Text(authority.state),
                    subtitle: Text(authority.authorityName),
                    trailing: const Icon(Icons.launch),
                    onTap: () async {
                      final uri = Uri.parse(authority.website);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Could not launch ${authority.website}",
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/sports');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/profile');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/settings');
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
