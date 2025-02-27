import 'package:flutter/material.dart';
import 'package:notify/data/exams.dart';
import 'package:notify/data/notifiers.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewExamDetails extends StatelessWidget {
  final Exams examDetail;

  const ViewExamDetails({super.key, required this.examDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleText(examDetail.sector),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(context, "Posted On", examDetail.postDate,
                      Icons.calendar_month),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    context,
                    "Important Dates",
                    examDetail.importantDates.isNotEmpty
                        ? examDetail.importantDates.join(", ")
                        : "Not Available",
                    Icons.event_outlined,
                  ),
                ],
              ),
            ),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    "Age Limit",
                    examDetail.ageLimit.isNotEmpty
                        ? examDetail.ageLimit.join(", ")
                        : "Not Available",
                    Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    context,
                    "Qualification",
                    examDetail.qualification.isNotEmpty
                        ? examDetail.qualification.join(", ")
                        : "Not Available",
                    Icons.school,
                  ),
                ],
              ),
            ),
            _buildCard(
              child: _buildClickableLinks(context, examDetail.importantLinks),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child: const Text("🔔 Notify Me",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return ValueListenableBuilder(
        valueListenable: isLightModeNotifier,
        builder: (context, bool isLightMode, child) {
          final textColor = isLightMode ? Colors.black : Colors.white;
          final iconColor = isLightMode ? Colors.purple : Colors.white;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                    children: [
                      TextSpan(
                        text: "$label: ",
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
            ],
          );
        });
  }

  Widget _buildClickableLinks(BuildContext context, List<String> links) {
    if (links.isEmpty) {
      return const Text("No Important Links Available");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Important Links:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: links.map((link) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () => _launchURL(link),
                child: Row(
                  children: [
                    const Icon(Icons.link, size: 18, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        link,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _buildTitleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
