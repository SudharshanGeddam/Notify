import 'package:flutter/material.dart';

class SportsCardVertical extends StatelessWidget {
  const SportsCardVertical({
    super.key,
    required this.sportName,
    required this.sportDate,
    required this.sportTime,
    required this.sportDescription,
    required this.onTap,
  });

  final String sportName;
  final String sportDate;
  final String sportTime;
  final String sportDescription;
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
                Text(sportName, style: Theme.of(context).textTheme.titleSmall),
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
                    sportDescription,
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
                Text(sportDate, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
