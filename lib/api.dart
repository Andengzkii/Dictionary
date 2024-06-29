
import 'dart:convert';

import 'package:thesaurus/response_model.dart';
import 'package:http/http.dart' as http;

class API{
  static const String baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  static Future<ResponseModel> fetchMeaning(String word) async {
    final response = await http.get(Uri.parse("$baseURL$word"));
    if(response.statusCode==200){
      final data = json.decode(response.body);
      return ResponseModel.fromJson(data[0]);

    }else{
      throw Exception("Failed to load meaning");
    }
  }
}