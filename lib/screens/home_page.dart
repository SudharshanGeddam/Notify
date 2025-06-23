import 'package:flutter/material.dart';
import 'package:notify/app_widgets/elements_home_container.dart';
import 'package:notify/data/home_elements.dart';

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
              icon: Icon(Icons.notifications),
              color: Colors.white,
              iconSize: 32.0,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome to Notify 😉',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: homeElements.length,
                itemBuilder: (context, index) {
                  final element = homeElements[index];
                  return ElementsHomeContainer(
                    id: element['id'] as String,
                    title: element['title'] as String,
                    imageUrl: element['imageUrl'] as String,
                    onTap: () {
                      // Navigate to the respective page based on the id
                      if (element['id'] == '0') {
                        Navigator.pushNamed(context, '/exams');
                      } else if (element['id'] == '1') {
                        Navigator.pushNamed(context, '/sports');
                      } else if (element['id'] == '2') {
                        Navigator.pushNamed(context, '/roadmaps');
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
