import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Notify/app_widgets/pageview_home.dart';
import 'package:Notify/app_widgets/side_nav_bar_widget.dart';
import 'package:Notify/data/api_service.dart';
import 'package:Notify/data/notifiers.dart';
import 'package:Notify/data/theme_toggle_icon.dart';
import 'package:Notify/pages/exams_page.dart';
import 'package:Notify/pages/roadmaps_page.dart';
import 'package:Notify/pages/sports_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>?> _fetchProfile() async {
    final http.Response? response = await ApiService.getProfile();
    if (response != null && response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/notify-logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isLightModeNotifier.value = !isLightModeNotifier.value;
            },
            icon: ThemeToggleIcon(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder<Map<String, dynamic>?>(
                  future: _fetchProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Welcome, Guest!"),
                      );
                    } else {
                      final user = snapshot.data!['user'];
                      final fullName =
                          (user != null && user['fullName'] != null)
                              ? user['fullName']
                              : "Guest";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(height: 50),
                              Padding(
                                padding: EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "Welcome, ",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'assets/fonts/Inter'),
                                ),
                              ),
                              Text(
                                "$fullName...👋",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text(
                              "Trending on Notify!🔥 ",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'assets/fonts/Inter'),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const PageviewHome(),
              const SizedBox(height: 50),
              OpenViews(),
            ],
          ),
        ),
      ),
      drawer: const SideNavDrawerView(),
    );
  }
}

class OpenViews extends StatefulWidget {
  const OpenViews({super.key});

  @override
  State<OpenViews> createState() => OpenViewState();
}

class OpenViewState extends State<OpenViews> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLightModeNotifier,
        builder: (context, bool isLightMode, child) {
          final buttonBackgroundColor =
              isLightMode ? Colors.white : Colors.grey[800];
          final buttonSideColor = isLightMode ? Colors.black : Colors.white;
          final textColor = isLightMode ? Colors.purple : Colors.white;
          final arrowColor = isLightMode ? Colors.purple : Colors.white;

          return Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ExamsPage();
                      }));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      side: BorderSide(color: buttonSideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/exam.png',
                            width: 24, height: 24),
                        Text(
                          "Exams",
                          style: TextStyle(color: textColor),
                        ),
                        Icon(Icons.arrow_forward, color: arrowColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SportsPage();
                      }));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      side: BorderSide(color: buttonSideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/trophy.png',
                            width: 24, height: 24),
                        Text(
                          "Sports",
                          style: TextStyle(color: textColor),
                        ),
                        Icon(Icons.arrow_forward, color: arrowColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RoadmapsPage();
                      }));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      side: BorderSide(color: buttonSideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.map_sharp, color: Colors.green),
                        Text(
                          "Roadmaps",
                          style: TextStyle(color: textColor),
                        ),
                        Icon(Icons.arrow_forward, color: arrowColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
