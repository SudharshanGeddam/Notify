import 'package:flutter/material.dart';

import 'package:notify/app_widgets/horizontal_card_view_sports.dart';
import 'package:notify/app_widgets/side_nav_bar_widget.dart';
import 'package:notify/app_widgets/vertical_card_view.dart';

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
        backgroundColor: Colors.purple,
        title: Text('Sports'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const HorizontalCardViewSports(),
          const SizedBox(
            height: 25,
          ),
          const VerticalCardView(),
        ],
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}
