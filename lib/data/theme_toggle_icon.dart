import 'package:flutter/material.dart';
import 'package:Notify/data/notifiers.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLightModeNotifier,
      builder: (context, isLightMode, child) {
        return Icon(isLightMode ? Icons.dark_mode : Icons.light_mode);
      },
    );
  }
}
