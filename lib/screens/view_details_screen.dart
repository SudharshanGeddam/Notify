import 'package:flutter/material.dart';
import 'package:notify/data/exam_details.dart';
import 'package:notify/data/latest_exams_details.dart';

class ViewDetailsScreen extends StatelessWidget {
  const ViewDetailsScreen({super.key, required ExamDetails examDetails, required LatestExamsDetails latestExamsDetails});

  @override
  Widget build(BuildContext context) {
    return Text("ExamDetailsPage");
  }
}
