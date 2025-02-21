import 'package:flutter/material.dart';
import 'package:notify/pages/preference_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Notify',
                  applicationVersion: '1.0',
                  applicationLegalese: '@ Raghu Engineering',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.interests_rounded),
              title: Text('Preferences'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PreferencesPage();
                }));
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SwitchListTile(
                title: Text('Notifications'),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
