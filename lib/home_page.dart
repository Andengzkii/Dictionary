import 'package:flutter/material.dart';
import 'package:thesaurus/api.dart';
import 'package:thesaurus/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const HomePage({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  ResponseModel? responseModel;
  String noDataText = "Welcome to Thesaurus, Start searching";
  late TextEditingController _searchController;
  List<String> searchHistory = [];
  List<String> favoriteWords = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadSearchHistory();
    _loadFavoriteWords();
  }

  Future<void> _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> _loadFavoriteWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteWords = prefs.getStringList('favoriteWords') ?? [];
    });
  }

  Future<void> _saveFavoriteWords(List<String> words) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteWords', words);
  }

  Future<void> _saveSearchHistory(List<String> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', history);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchWidget(),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              _buildFavoriteWordsWidget(),
              const SizedBox(height: 12),
              if (inProgress)
                const LinearProgressIndicator()
              else if (responseModel != null)
                Expanded(child: _buildResponseWidget())
              else
                _noDataWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search Word Here",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _onSubmitted(_searchController.text);
              },
            ),
          ),
          onSubmitted: _onSubmitted,
        ),
        const SizedBox(height: 12),
        _buildSearchHistoryWidget(),
      ],
    );
  }

  Widget _buildSearchHistoryWidget() {
    if (searchHistory.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Search History:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: searchHistory
                .map((history) => Chip(
                      label: Text(history),
                      onDeleted: () {
                        _removeFromHistory(history);
                      },
                    ))
                .toList(),
          ),
        ],
      );
    }
  }

 
  Widget _buildFavoriteWordsWidget() {
    if (favoriteWords.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Favorite Words:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: favoriteWords
                .map((word) => Chip(
                      label: Text(word),
                      onDeleted: () {
                        _removeFromFavorites(word);
                      },
                    ))
                .toList(),
          ),
        ],
      );
    }
  }

  void _onSubmitted(String value) async {
    if (value.isNotEmpty) {
      _searchController.clear();
      await _getMeaningFromApi(value);
      _addToHistory(value);
    }
  }

  Future<void> _getMeaningFromApi(String word) async {
    setState(() {
      inProgress = true;
    });
    try {
      responseModel = await API.fetchMeaning(word);
      setState(() {});
    } catch (e) {
      responseModel = null;
      noDataText = "Meaning cannot be fetched";
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  void _addToHistory(String value) async {
    setState(() {
      if (!searchHistory.contains(value)) {
        searchHistory.insert(0, value);
        _saveSearchHistory(searchHistory);
      }
    });
  }

  void _removeFromHistory(String value) async {
    setState(() {
      searchHistory.remove(value);
      _saveSearchHistory(searchHistory);
    });
  }

  void _addToFavorites(String word) async {
    setState(() {
      if (!favoriteWords.contains(word)) {
        favoriteWords.add(word);
        _saveFavoriteWords(favoriteWords);
      }
    });
  }

  void _removeFromFavorites(String word) async {
    setState(() {
      favoriteWords.remove(word);
      _saveFavoriteWords(favoriteWords);
    });
  }

  Widget _buildResponseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              responseModel!.word!,
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            IconButton(
              icon: Icon(
                favoriteWords.contains(responseModel!.word)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                if (favoriteWords.contains(responseModel!.word)) {
                  _removeFromFavorites(responseModel!.word!);
                } else {
                  _addToFavorites(responseModel!.word!);
                }
              },
            ),
          ],
        ),
        Text(responseModel!.phonetic ?? ""),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildMeaningWidget(responseModel!.meanings![index]);
            },
            itemCount: responseModel!.meanings!.length,
          ),
        ),
      ],
    );
  }

  Widget _buildMeaningWidget(Meanings meanings) {
    String definitionList = "";
    meanings.definitions?.forEach(
      (element) {
        int index = meanings.definitions!.indexOf(element);
        definitionList += "\n${index + 1}. ${element.definition}\n";
      },
    );

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: Colors.pink.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions :",
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(definitionList),
            _buildSet("Synonyms", meanings.synonyms),
            _buildSet("Antonyms", meanings.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: Color.fromARGB(221, 240, 41, 180),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            setList!
                .toSet()
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", ""),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _noDataWidget() {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          noDataText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
