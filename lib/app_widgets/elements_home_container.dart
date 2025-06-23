import 'package:flutter/material.dart';

class ElementsHomeContainer extends StatelessWidget {
  const ElementsHomeContainer({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });
  final String id;
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromRGBO(164, 216, 255, 1),
        ),
        child: Column(
          children: [
            Image.asset(imageUrl, height: 150, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
