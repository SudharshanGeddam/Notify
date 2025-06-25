import 'package:flutter/material.dart';
import 'package:notify/data/exam_details.dart';
import 'package:notify/data/latest_exams_details.dart';
import 'package:notify/screens/view_details_screen.dart';

class LatestExamsCard extends StatelessWidget {
  const LatestExamsCard({
    super.key,
    required this.latestExamsDetails,
    required this.examDetails,
  });
  final LatestExamsDetails latestExamsDetails;
  final ExamDetails examDetails;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.catching_pokemon,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                _buildText(context, "Sector:", latestExamsDetails.sector),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                _buildText(context, "PostedOn:", latestExamsDetails.postDate),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                _buildText(context, "Status:", latestExamsDetails.updateInfo),
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ViewDetailsScreen(
                        latestExamsDetails: latestExamsDetails,
                        examDetails: examDetails,
                      );
                    },
                  ),
                );
              },
              child: Text("View Details", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleMedium,
            children: [
              TextSpan(
                text: title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' $value',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              
            ],
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
