import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'word_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dictionary',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
      routes: {
        '/settings': (context) => SettingsPage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
        '/word_detail': (context) => WordDetailPage(word: ''),
      },
    );
  }
}
