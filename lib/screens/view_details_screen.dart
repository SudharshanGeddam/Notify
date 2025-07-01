import 'package:flutter/material.dart';
import 'package:notify/data/jobs_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewDetailsScreen extends StatelessWidget {
  final JobsData jobDetails;

  const ViewDetailsScreen({super.key, required this.jobDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Details"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleText(jobDetails.postDate),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    "Post Board",
                   jobDetails.postBoard,
                    Icons.list,
                  ),
                  const SizedBox(height: 10),
                  _buildQualificationSection(context, jobDetails.qualification),
                ],
              ),
              context: context,
            ),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    "Post Name",
                    jobDetails.postName,
                    Icons.bookmark,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    context,
                    "Last Date",
                    jobDetails.lastDate,
                    Icons.event,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    context,
                    "Details Link",
                    jobDetails.link,
                    Icons.link,
                  ),
                ],
              ),
              context: context,
            ),
            _buildCard(
              context: context,
              child: _buildClickableLinks(context, jobDetails.applyOnline as List<String>),
            ),
            _buildCard(
              context: context,
              child: _buildClickableLinks(context, [jobDetails.officialWebsite]),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text("🔔 Notify Me"),
                ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).iconTheme.color),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
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
  }

  Widget _buildQualificationSection(BuildContext context, List<String> qualifications) {
    if (qualifications.isEmpty) {
      return const Text("No Qualifications Mentioned");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Qualifications:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: qualifications.map((qualification) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      qualification,
                      style: const TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
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
                    Icon(
                      Icons.link,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
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

  Widget _buildCard({required Widget child, required BuildContext context}) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _buildTitleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
