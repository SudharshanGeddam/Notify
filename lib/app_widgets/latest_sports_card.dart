import 'package:flutter/material.dart';

class LatestSportsCard extends StatelessWidget {
  const LatestSportsCard({
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
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Icon(Icons.article, size: 40, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 5),
                    Text(
                      sportName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ],
                  ),
                  
                  const SizedBox(height: 10),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Icon(Icons.article, size: 40, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 5),
                    Text(
                      sportDescription,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ],
                  ),
                  const SizedBox(height: 10),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Icon(Icons.article, size: 40, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 5),
                    Text(
                      sportDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ],
                  ),
                ],
              )
            ),
          
    );
  }
}
