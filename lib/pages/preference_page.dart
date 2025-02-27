import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  PreferencesPageState createState() => PreferencesPageState();
}

class PreferencesPageState extends State<PreferencesPage> {
  bool? isCheckedExams = false;
  bool? isCheckedSports = false;
  bool? isCheckedTeaching = false;
  bool? isCheckedBanking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              tristate: true,
              title: const Text('Exams'),
              value: isCheckedExams,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedExams = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sports'),
              tristate: true,
              value: isCheckedSports,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedSports = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Teaching'),
              tristate: true,
              value: isCheckedTeaching,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedTeaching = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Banking'),
              tristate: true,
              value: isCheckedBanking,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedBanking = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
