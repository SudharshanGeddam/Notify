import 'package:flutter/material.dart';

import 'package:notify/app_widgets/side_nav_bar_widget.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
        ],
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}
