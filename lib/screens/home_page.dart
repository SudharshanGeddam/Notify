import 'package:flutter/material.dart';
import 'package:notify/app_widgets/home_page_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              buildWideOutlinedButton(
                context: context,
                label: 'Exams',
                imagePath: 'assets/images/exams.jpg',
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/exams');
                },
              ),
              const SizedBox(height: 20),

              // Sports Button
              buildWideOutlinedButton(
                context: context,
                label: 'Sports',
                imagePath: 'assets/images/sports.jpg',
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/sports');
                },
              ),
              const SizedBox(height: 20),

              // Roadmaps Button
              buildWideOutlinedButton(
                context: context,
                label: 'Roadmaps',
                imagePath: 'assets/images/roadmaps.jpg',
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/roadmaps');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable wide outlined button with leading image and trailing icon
  Widget buildWideOutlinedButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    required String imagePath,
    required IconData trailingIcon,
  }) {
    return SizedBox(
      width: 300,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
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
