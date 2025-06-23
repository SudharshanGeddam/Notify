import 'package:flutter/material.dart';

class ExamsCardVertical extends StatelessWidget {
  const ExamsCardVertical({
    super.key,
    required this.examName,
    required this.examDate,
    required this.examTime,
    required this.examDescription,
    required this.onTap,
  });

  final String examName;
  final String examDate;
  final String examTime;
  final String examDescription;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(12.0),
        color: Color.fromRGBO(229, 244, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.article,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Text(examName, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.article,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    examDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.article,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Text(examDate, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
