import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteWords;

  const FavoritesPage({Key? key, required this.favoriteWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Words'),
      ),
      body: ListView.builder(
        itemCount: favoriteWords.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteWords[index]),
          );
        },
      ),
    );
  }
}
