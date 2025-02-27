import 'package:Notify/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:Notify/data/api_service.dart';
import 'package:Notify/data/exams.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class PageviewExams extends StatefulWidget {
  const PageviewExams({super.key});

  @override
  State<PageviewExams> createState() => _PageViewJobState();
}

class _PageViewJobState extends State<PageviewExams> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

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
        content: Text("Something went wrong!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: examsList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 160,
                        child: ExamCard(
                            isDarkMode: isDarkMode,
                            examDetail: examsList[index]),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              10,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 10 : 8,
                height: _currentIndex == index ? 10 : 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? (isDarkMode ? Colors.white : Colors.black)
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final bool isDarkMode;
  final Exams examDetail;

  const ExamCard({
    super.key,
    required this.isDarkMode,
    required this.examDetail,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLightModeNotifier,
        builder: (context, bool isLightMode, child) {
          final borderColor = isLightMode ? Colors.black : Colors.white;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 100,
                maxHeight: 160,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: borderColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText("Sector", examDetail.sector),
                        _buildText("Date Released", examDetail.postDate),
                        _buildText("Status", examDetail.updateInformation),
                        GestureDetector(
                          onTap: () =>
                              _openLink(context, examDetail.detailLink),
                          child: Text(
                            "View More",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkMode ? Colors.blue[200] : Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Lottie.asset('assets/lotties/New.json',
                          repeat: true, animate: true),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildText(String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }

  void _openLink(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid URL: URL is empty")),
      );
      return;
    }

    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "https://$url";
    }

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open link")),
      );
    }
  }
}
