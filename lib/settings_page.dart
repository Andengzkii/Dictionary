import 'package:flutter/material.dart';
import 'about_page.dart'; // Import the AboutPage
import 'policy_page.dart'; // Import the PolicyPage

class SettingsPage extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  SettingsPage({required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (bool value) {
                toggleTheme(value);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              title: Text('Policy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
