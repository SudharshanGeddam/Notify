import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Center(
          child: Text(
            'Settings Page',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}