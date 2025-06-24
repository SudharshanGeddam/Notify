/*
import 'package:flutter/material.dart';
import 'package:notify/app_widgets/exams_card_vertical.dart';

import 'package:notify/app_widgets/filter_list_view.dart';
import 'package:notify/app_widgets/latest_exams_card.dart';
import 'package:notify/data/exam_details.dart';

import 'package:notify/data/filters_data.dart';
import 'package:notify/data/latest_exams_details.dart';

class ExamsHome extends StatefulWidget {
  const ExamsHome({super.key});

  @override
  State<ExamsHome> createState() => _ExamsHomeState();
}

class _ExamsHomeState extends State<ExamsHome> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Exams')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
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
                  itemCount: latestexamsDetails.length,

                  itemBuilder: (context, index) {
                    final exam = latestexamsDetails[index];
                    return LatestExamsCard(
                      examName: exam['title'] ?? 'No Title',
                      examDate: exam['date'] ?? 'No Date',
                      examTime: exam['time'] ?? 'No Time',
                      examDescription: exam['description'] ?? 'No Description',
                      onTap: () {},
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for exams...',
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
                itemCount: examDetails.length,
                itemBuilder: (context, index) {
                  final exam = examDetails[index];
                  return ExamsCardVertical(
                    examName: exam['title'] ?? 'No Title',
                    examDate: exam['date'] ?? 'No Date',
                    examTime: exam['time'] ?? 'No Time',
                    examDescription: exam['description'] ?? 'No Description',
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
              Navigator.pushReplacementNamed(context, '/exams');
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
*/
