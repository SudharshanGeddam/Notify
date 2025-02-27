import 'package:flutter/material.dart';
import 'package:Notify/data/api_service.dart';
import 'package:Notify/data/exams.dart';
import 'package:Notify/data/notifiers.dart';
import 'package:Notify/pages/view_exam_details.dart';

class VerticalCardViewExams extends StatefulWidget {
  const VerticalCardViewExams({super.key});

  @override
  State<VerticalCardViewExams> createState() => _VerticalCardViewExamsState();
}

class _VerticalCardViewExamsState extends State<VerticalCardViewExams> {
  List<Exams> examsList = [];

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    try {
      List<dynamic> exams = await ApiService().fetchExams();
      setState(() {
        examsList = exams.cast<Exams>();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong! Please try again later."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: examsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: examsList.length,
              itemBuilder: (context, index) {
                return VerticalExamCardView(
                  isDarkMode: isDarkMode,
                  examDetail: examsList[index],
                );
              },
            ),
    );
  }
}

class VerticalExamCardView extends StatelessWidget {
  final bool isDarkMode;
  final Exams examDetail;

  const VerticalExamCardView({
    super.key,
    required this.isDarkMode,
    required this.examDetail,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLightModeNotifier,
        builder: (context, bool isLightMode, child) {
          final iconColor = isLightMode ? Colors.black : Colors.blue;
          final buttonColor = isLightMode ? Colors.purple : Colors.blue;
          final borderColor = isLightMode ? Colors.black : Colors.white;

          return Card(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor)),
            elevation: 3,
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.catching_pokemon,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(width: 10),
                        _buildText("Sector", examDetail.sector),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(width: 10),
                        _buildText("PostedOn", examDetail.postDate)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(width: 10),
                        _buildText("Status", examDetail.updateInformation),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewExamDetails(examDetail: examDetail);
                        }));
                      },
                      child: Text(
                        "View Details",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            children: [
              TextSpan(
                text: "$title: ",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              ),
              TextSpan(text: value),
            ],
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
