import 'package:flutter/material.dart';
import 'package:notify/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListTile(
          title: const Text("Dark Mode"),
          trailing: Switch(
            value: themeProvider.isDarkTheme,
            onChanged: (value) => themeProvider.toggleTheme(),
          ),
        ),
      ),
    );
  }
}
