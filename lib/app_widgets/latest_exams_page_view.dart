import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/data/latest_exams_details.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestExamsPageView extends StatefulWidget {
  const LatestExamsPageView({super.key});

  @override
  State<LatestExamsPageView> createState() => _PageViewJobState();
}

class _PageViewJobState extends State<LatestExamsPageView> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;
  List<LatestExamsDetails> examsList = [];

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
  try {
    final exams = await ApiService().fetchLatestExams().timeout(const Duration(seconds: 60));
    if (!mounted) return; 
    setState(() {
     final limitedExams = (exams ?? []).take(10).toList();
        examsList = limitedExams;
    });
  } on TimeoutException {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request timed out")),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong!")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: examsList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: examsList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 160,
                        child: ExamCard(examDetail: examsList[index]),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              examsList.length,
              (index) => Container(
                width: _currentIndex == index ? 10 : 8,
                height: _currentIndex == index ? 10 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final LatestExamsDetails examDetail;

  const ExamCard({super.key, required this.examDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText("Sector", examDetail.postBoard),
              _buildText("Date Released", examDetail.postDate),
              _buildText("Last Date", examDetail.lasteDate),
              GestureDetector(
                onTap: () => _openLink(context, examDetail.applyOnline),
                child: Text(
                  "View More",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                  text: "$title: ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLink(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid URL: URL is empty")),
      );
      return;
    }

    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "https://$url";
    }

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not open link")));
    }
  }
}
