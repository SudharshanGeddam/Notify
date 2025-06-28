import 'package:flutter/material.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/data/exam_details.dart';
import 'package:notify/screens/view_details_screen.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<JobDetails> jobDetailsList = [];

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    try {
      List<JobDetails>? exams = await ApiService().fetchJobs().timeout(
        const Duration(seconds: 60),
      );
      if (!mounted) return;
      setState(() {
        jobDetailsList = (exams ?? []).take(10).toList(); // limit to 10
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please check your Internet connection!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Required to render horizontal list
      child: jobDetailsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: jobDetailsList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return HomePageViewLatest(jobDetails: jobDetailsList[index]);
              },
            ),
    );
  }
}

class HomePageViewLatest extends StatelessWidget {
  final JobDetails jobDetails;
  const HomePageViewLatest({super.key, required this.jobDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Needed for horizontal card display
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(
            context,
            Icons.catching_pokemon,
            "Posted Board",
            jobDetails.postBoard,
          ),
          _buildRow(
            context,
            Icons.calendar_month,
            "Posted On",
            jobDetails.postDate,
          ),
          _buildRow(context, Icons.list, "Last Date", jobDetails.lastDate),
          _buildRow(
            context,
            Icons.list,
            "Details Link",
            jobDetails.detailsLink,
          ),
          _buildRow(
            context,
            Icons.list,
            "Official Website",
            jobDetails.officialWebsite,
          ),
          const Spacer(),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewDetailsScreen(jobDetails: jobDetails),
                ),
              );
            },
            child: const Text("View Details", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 10),
          Expanded(child: _buildText(context, title, value)),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String title, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
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
