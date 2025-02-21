import 'package:flutter/material.dart';
import 'package:notify/app_widgets/horizontal_card_view_exams.dart';
import 'package:notify/app_widgets/side_nav_bar_widget.dart';
import 'package:notify/app_widgets/vertical_card_view.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Grow with Us'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const HorizontalCardViewExams(),
          const SizedBox(
            height: 20,
          ),
          const VerticalCardView(),
        ],
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}
