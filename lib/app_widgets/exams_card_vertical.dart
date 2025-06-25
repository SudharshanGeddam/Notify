import 'package:flutter/material.dart';
import 'package:notify/data/exam_details.dart';
import 'package:notify/data/latest_exams_details.dart';
import 'package:notify/screens/view_details_screen.dart';

class ExamsCardVertical extends StatelessWidget {
  const ExamsCardVertical({
    super.key,
    required this.examDetails,
    required this.latestExamsDetails,
  });

  final ExamDetails examDetails;
  final LatestExamsDetails latestExamsDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      color: Color.fromRGBO(229, 244, 255, 1),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),

        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.catching_pokemon,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 5),
              _buildText(context, "Post Name:", examDetails.postName),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 5),
              _buildText(context, "PostedOn:", examDetails.postDate),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.list,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 5),
              _buildText(context, "Apply Online:", examDetails.applyOnline),
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
                      examDetails: examDetails,
                      latestExamsDetails: latestExamsDetails,
                    );
                  },
                ),
              );
            },
            child: Text("View Details", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
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
