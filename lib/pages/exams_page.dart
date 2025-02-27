import 'package:flutter/material.dart';

import 'package:notify/app_widgets/pageview_exams.dart';
import 'package:notify/app_widgets/side_nav_bar_widget.dart';
import 'package:notify/app_widgets/vertical_card_view_exams.dart';

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
        title: Text(
          'Exams',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "Recently Released!",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const PageviewExams(),
          const SizedBox(height: 20),
          Expanded(child: VerticalCardViewExams()),
        ],
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}
