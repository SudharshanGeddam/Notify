import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPageExams extends StatefulWidget {
  const SearchPageExams({super.key});

  @override
  State<SearchPageExams> createState() => _SearchPageExamsState();
}

class _SearchPageExamsState extends State<SearchPageExams> {
  final List<Map<String, dynamic>> exams = [
    {
      "title": "IELTS Academic Test",
      "date": "March 15, 2024",
      "deadline": "Feb 28, 2024",
      "center": "Cambridge Assessment",
      "isNew": true,
    },
    {
      "title": "GRE General Test",
      "date": "April 5, 2024",
      "deadline": "March 20, 2024",
      "center": "ETS Testing Center",
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Exam...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(label: "All", isSelected: true),
                FilterButton(label: "Upcoming", isSelected: false),
                FilterButton(label: "Past", isSelected: false),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton(
      {super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.purple : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label, style: GoogleFonts.poppins()),
    );
  }
}
