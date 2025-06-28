import 'package:flutter/material.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/data/exam_details.dart';
import 'package:notify/screens/view_details_screen.dart';

class VerticalCardViewExams extends StatefulWidget {
  const VerticalCardViewExams({super.key});

  @override
  State<VerticalCardViewExams> createState() => _VerticalCardViewExamsState();
}

class _VerticalCardViewExamsState extends State<VerticalCardViewExams> {
  List<JobDetails> examsList = [];

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    try {
      List<JobDetails>? exams = await ApiService().fetchJobs().timeout(
        Duration(seconds: 60),
      );
      setState(() {
        examsList = (exams ?? []).cast<JobDetails>();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong! Please try again later."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: examsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: examsList.length,
              itemBuilder: (context, index) {
                return VerticalExamCardView(examDetail: examsList[index]);
              },
            ),
    );
  }
}

class VerticalExamCardView extends StatelessWidget {
  final JobDetails examDetail;

  const VerticalExamCardView({super.key, required this.examDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(Icons.catching_pokemon, "Sector", examDetail.postBoard),
            _buildRow(Icons.calendar_month, "Posted On", examDetail.postDate),
            _buildRow(Icons.list, "Last Date", examDetail.lastDate),
            const SizedBox(height: 10),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromRGBO(56, 182, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewDetailsScreen(jobDetails: examDetail),
                  ),
                );
              },
              child: const Text("View Details", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color.fromRGBO(56, 182, 255, 1)),
          const SizedBox(width: 10),
          Expanded(child: _buildText(title, value)),
        ],
      ),
    );
  }

  Widget _buildText(String title, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black),
        children: [
          TextSpan(
            text: "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
