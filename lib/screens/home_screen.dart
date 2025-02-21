import 'package:flutter/material.dart';
import 'package:notify/app_widgets/pageview_home.dart';
import 'package:notify/app_widgets/side_nav_bar_widget.dart';

import 'package:notify/data/notifiers.dart';
import 'package:notify/pages/exams_page.dart';
import 'package:notify/pages/roadmaps_page.dart';
import 'package:notify/pages/sports_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: Row(
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
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                isLightModeNotifier.value = !isLightModeNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isLightModeNotifier,
                builder: (context, isLightMode, child) {
                  return Icon(isLightMode ? Icons.dark_mode : Icons.light_mode);
                },
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          const PageviewHome(),
          const SizedBox(height: 50),
          const Expanded(child: OpenViews()),
        ],
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
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 300,
            child: FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SportsPage();
                }));
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/trophy.png',
                      width: 24, height: 24),
                  const Text(
                    "Sports",
                    style: TextStyle(color: Colors.purple),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.purple),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamsPage();
                }));
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/exam.png', width: 24, height: 24),
                  const Text(
                    "Exams",
                    style: TextStyle(color: Colors.purple),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.purple),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RoadmapsPage();
                }));
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.map_sharp, color: Colors.green),
                  const Text(
                    "Roadmaps",
                    style: TextStyle(color: Colors.purple),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.purple),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
