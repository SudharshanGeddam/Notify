import 'package:flutter/material.dart';

import 'package:notify/app_widgets/filter_list_view.dart';

import 'package:notify/app_widgets/latest_sports_card.dart';
import 'package:notify/app_widgets/sports_card_vertical.dart';

import 'package:notify/data/filters_data.dart';

import 'package:notify/data/latest_sports_details.dart';
import 'package:notify/data/sports_details.dart';

class SportsHome extends StatefulWidget {
  const SportsHome({super.key});

  @override
  State<SportsHome> createState() => _SportsHomeState();
}

class _SportsHomeState extends State<SportsHome> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sports')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.start,
                'Trending on Notify...🔥',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: latestsportsDetails.length,

                  itemBuilder: (context, index) {
                    final sports = latestsportsDetails[index];
                    return LatestSportsCard(
                      sportName: sports['title'] ?? 'No Title',
                      sportDate: sports['date'] ?? 'No Date',
                      sportTime: sports['time'] ?? 'No Time',
                      sportDescription:
                          sports['description'] ?? 'No Description',
                      onTap: () {},
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for sports...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FilterListView(
                filters: filters,
                onFilterSelected: (String selected) {},
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sportsDetails.length,
                itemBuilder: (context, index) {
                  final sports = sportsDetails[index];
                  return SportsCardVertical(
                    sportName: sports['title'] ?? 'No Title',
                    sportDate: sports['date'] ?? 'No Date',
                    sportTime: sports['time'] ?? 'No Time',
                    sportDescription: sports['description'] ?? 'No Description',
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/sports');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/profile');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/settings');
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
