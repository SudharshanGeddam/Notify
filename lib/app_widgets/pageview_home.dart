import 'package:flutter/material.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/data/jobs.dart';
import 'package:url_launcher/url_launcher.dart';

class PageviewHome extends StatefulWidget {
  const PageviewHome({super.key});

  @override
  State<PageviewHome> createState() => _PageViewJobState();
}

class _PageViewJobState extends State<PageviewHome> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

  List<Job> jobList = [];

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      List<dynamic> jobs = await ApiService().fetchJobs();
      setState(() {
        jobList = jobs.cast<Job>();
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
            height: 200,
            child: jobList.isEmpty
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
                      return JobCard(
                          isDarkMode: isDarkMode, job: jobList[index]);
                    },
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              jobList.length,
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

class JobCard extends StatelessWidget {
  final bool isDarkMode;
  final Job job;
  const JobCard({super.key, required this.isDarkMode, required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.white12 : Colors.black26,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText("Category", job.postBoard),
              _buildText("Date Released", job.postDate),
              _buildText("Qualification", job.qualification),
              _buildText("Last Date", job.lastDate),
              GestureDetector(
                onTap: () => _openLink(context, job.link),
                child: Text(
                  "View More",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.blue[200] : Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String title, String value) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            children: [
              TextSpan(
                text: "$title: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: value),
            ],
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
