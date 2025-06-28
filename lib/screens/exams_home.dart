import 'package:flutter/material.dart';
import 'package:notify/app_widgets/exams_card_vertical.dart';
import 'package:notify/app_widgets/filter_list_view.dart';
import 'package:notify/app_widgets/latest_exams_page_view.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    try {
      final latestExams = await ApiService().fetchLatestExams();
      final examDetails = await ApiService().fetchExams();

      setState(() {
        latestExamDetailsList = latestExams ?? [];
        examDetailsList = examDetails ?? [];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading exam details: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong! Please try again later."),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Exams')),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Trending on Notify...🔥',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    LatestExamsPageView(),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for exams...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (query) {
                        // Optional: Implement search functionality here.
                      },
                    ),
                    const SizedBox(height: 10),
                    FilterListView(
                      filters: filters,
                      onFilterSelected: (String selected) {
                        // Optional: Filter logic based on selected item
                      },
                    ),
                    const SizedBox(height: 10),
                    VerticalCardViewExams(),
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
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
