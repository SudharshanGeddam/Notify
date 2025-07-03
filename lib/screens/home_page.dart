import 'package:flutter/material.dart';
import 'package:notify/app_widgets/home_page_view.dart';
import 'package:notify/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notify'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_sharp),
              color: Theme.of(context).iconTheme.color,
              iconSize: 32.0,
            ),
          ],
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isDark
                      ? 'assets/images/dark_bg.png'
                      : 'assets/images/auth_bg.jpg',
                  key: ValueKey<bool>(isDark),
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! Welcome to Notify 👋',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const HomePageView(),
                    const SizedBox(height: 30),

                    // Exams Button
                    Align(
                      alignment: Alignment.center,
                      child: buildWideOutlinedButton(
                        context: context,
                        isDarkTheme: isDark,
                        label: 'Exams',
                        imagePath: 'assets/images/exams.jpg',
                        trailingIcon: Icons.arrow_forward_ios,

                        onPressed: () {
                          Navigator.pushNamed(context, '/exams');
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sports Button
                    Align(
                      alignment: Alignment.center,
                      child: buildWideOutlinedButton(
                        context: context,
                        isDarkTheme: isDark,
                        label: 'Sports',
                        imagePath: 'assets/images/sports.jpg',
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.pushNamed(context, '/sports');
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Roadmaps Button
                    Align(
                      alignment: Alignment.center,
                      child: buildWideOutlinedButton(
                        context: context,
                        isDarkTheme: isDark,
                        label: 'Roadmaps',
                        imagePath: 'assets/images/roadmaps.jpg',
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.pushNamed(context, '/roadmaps');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWideOutlinedButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    required String imagePath,
    required IconData trailingIcon,
    required bool isDarkTheme,
  }) {
    return SizedBox(
      width: 300,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          backgroundColor: isDarkTheme ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imagePath, height: 50),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(trailingIcon, color: Theme.of(context).iconTheme.color),
          ],
        ),
      ),
    );
  }
}
