import 'package:flutter/material.dart';

class SearchPageSports extends StatefulWidget {
  const SearchPageSports({super.key});

  @override
  State<SearchPageSports> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPageSports> {
  final List<Map<String, String>> _allItems = [
    {'title': 'Cricket Tournament', 'category': 'Sports'},
    {'title': 'Football League', 'category': 'Sports'},
    {'title': 'UPSC Exam', 'category': 'Exams'},
    {'title': 'JEE Main', 'category': 'Exams'},
    {'title': 'Flutter Development Roadmap', 'category': 'Roadmaps'},
    {'title': 'Machine Learning Roadmap', 'category': 'Roadmaps'},
    {'title': 'Exam Notifications', 'category': 'Notifications'},
    {'title': 'Sports Updates', 'category': 'Notifications'},
  ];

  List<Map<String, String>> _searchResults = [];

  void _updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = _allItems;
      } else {
        _searchResults = _allItems
            .where((item) =>
                item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _updateSearchResults,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: _allItems.isEmpty
                    ? ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final item = _searchResults[index];
                          return ListTile(
                            leading: Icon(_getCategoryIcon(item['category']!)),
                            title: Text(item['title']!),
                            subtitle: Text(item['category']!),
                          );
                        })
                    : Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  IconData? _getCategoryIcon(String category) {
    switch (category) {
      case 'Sports':
        return Icons.sports_soccer;
      case 'Exams':
        return Icons.school_outlined;
      case 'Roadmaps':
        return Icons.map;
      default:
        return Icons.help_outline;
    }
  }
}
