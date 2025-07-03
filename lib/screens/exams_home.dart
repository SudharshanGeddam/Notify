import 'package:flutter/material.dart';
import 'package:notify/app_widgets/filter_list_view.dart';
import 'package:notify/app_widgets/home_page_view.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/data/filters_data.dart';
import 'package:notify/data/jobs_data.dart';
import 'package:notify/screens/view_details_screen.dart';
import 'package:notify/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ExamsHome extends StatefulWidget {
  const ExamsHome({super.key});

  @override
  State<ExamsHome> createState() => _ExamsHomeState();
}

class _ExamsHomeState extends State<ExamsHome> {
  List<JobsData> _jobList = [];
  String _selectedFilter = 'All';
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadJobsForFilter(_selectedFilter);
  }

  // Loading exams and jobs details.
  Future<void> loadJobsForFilter(String selected) async {
    // setState(() {

    // });
    try {
      final path = filterPaths[selected];
      if (path == null) throw Exception('Invalid filter path');

      final endpoint = '${ApiService.baseUrl}$path';
      final jobs = await ApiService().fetchJobs(endpoint);

      setState(() {
        _selectedFilter = selected;
        _jobList = jobs;
      });
    } catch (e) {
      throw Exception('Unable to parse URI: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Exam Notifications')),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isDark
                      ? 'assets/images/dark_bg.png'
                      : 'assets/images/auth_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Recently Release',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const HomePageView(),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for exams...',
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
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
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          loadJobsForFilter(selected);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _jobList.length,
                      itemBuilder: (context, index) {
                        return VerticalCardViewForJobs(jobs: _jobList[index]);
                      },
                    ),
                  ],
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

class VerticalCardViewForJobs extends StatelessWidget {
  final JobsData jobs;

  const VerticalCardViewForJobs({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey),
      ),
      color: isDark ? Color.fromRGBO(229, 244, 255, 1) : Colors.white,
      elevation: 3,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(Icons.catching_pokemon, "Sector", jobs.postBoard),
            _buildRow(Icons.calendar_month, "Posted On", jobs.postDate),
            _buildRow(Icons.list, "Last Date", jobs.lastDate),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(56, 182, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDetailsScreen(jobDetails: jobs),
                    ),
                  );
                },
                child: const Text("View Details", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(icon, size: 16, color: const Color.fromRGBO(56, 182, 255, 1)),
        const SizedBox(width: 10),
        Expanded(child: _buildText(title, value)),
      ],
    ),
  );
}

Widget _buildText(String title, String value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontSize: 14, color: Colors.black),
      children: [
        TextSpan(
          text: "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
        ),
        TextSpan(text: value),
      ],
    ),
  );
}
