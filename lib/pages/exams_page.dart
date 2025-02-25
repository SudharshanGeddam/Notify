import 'package:flutter/material.dart';
import 'package:notify/app_widgets/horizontal_card_view_exams.dart';
import 'package:notify/app_widgets/side_nav_bar_widget.dart';

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
        title: Text('Exam Notifications'),
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
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const HorizontalCardViewExams(),
          const SizedBox(height: 20),
        ],
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}
