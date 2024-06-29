import 'package:flutter/material.dart';

class WordDetailPage extends StatelessWidget {
  final String word;

  WordDetailPage({required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Word: $word',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Definition: This is a placeholder for the word definition.',
              style: TextStyle(fontSize: 18),
            ),
            // Add more word details here
          ],
        ),
      ),
    );
  }
}