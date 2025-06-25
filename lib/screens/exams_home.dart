import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notify/app_widgets/exams_card_vertical.dart';

import 'package:notify/app_widgets/filter_list_view.dart';
import 'package:notify/app_widgets/latest_exams_card.dart';
import 'package:notify/data/api_service.dart';
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
  List<LatestExamsDetails> latestExamDetailsList = [];
  List<ExamDetails> examDetailsList = [];
  int get listLength => min(examDetailsList.length, latestExamDetailsList.length);

  @override
  void initState() {
    super.initState();
    // Initialize examDetailsList with data from examDetails
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    try {
      final latestExams = await ApiService().fetchLatestExams();
      final examDetails = await ApiService().fetchExams();
      setState(() {
        latestExamDetailsList = latestExams?.cast<LatestExamsDetails>() ?? [];
        examDetailsList = examDetails?.cast<ExamDetails>() ?? [];
      });
    } catch (e) {
      print('Error loading exam details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong! Please try again after sometime.",
          ),
        ),
      );
    }
  }

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
                child: latestExamDetailsList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: latestExamDetailsList.length,
                        itemBuilder: (context, index) {
                         if(index<examDetailsList.length && index<latestExamDetailsList.length){
                            return LatestExamsCard(
                              latestExamsDetails: latestExamDetailsList[index],
                              examDetails: examDetailsList[index],
                            );
                         } else {
                            return const SizedBox.shrink();
                         }
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
              SizedBox(
                height: 200,
                child: examDetailsList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: examDetailsList.length,
                        itemBuilder: (context, index) {
                          return ExamsCardVertical(
                            examDetails: examDetailsList[index],
                            latestExamsDetails: latestExamDetailsList[index],
                          );
                        },
                      ),
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
