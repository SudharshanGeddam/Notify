import 'package:flutter/material.dart';

class Roadmaps extends StatelessWidget {
  const Roadmaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roadmaps'), centerTitle: true),
      body: Center(
        child: Text(
          'Roadmaps Home Page',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
