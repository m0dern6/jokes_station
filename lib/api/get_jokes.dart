import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_station/api/endpoints.dart';

class GetJokes with ChangeNotifier {
  Map<String, dynamic> jokes = {};
  Future<void> getRandomJokes() async {
    final response = await http.get(Uri.parse(Endpoints.randomJokes));
    if (response.statusCode == 200) {
      jokes = jsonDecode(response.body) as Map<String, dynamic>;

      notifyListeners();
    } else {
      print('Failed to load jokes ${response.statusCode} ${response.body}');
    }
  }

 Future<void> getSpecificJokes(String category) async {
    final response = await http.get(Uri.parse(
        'https://official-joke-api.appspot.com/jokes/$category/random'));
    if (response.statusCode == 200) {
      print('Success ${response.body}');
      List<dynamic> jokesList = jsonDecode(response.body) as List<dynamic>;
      if (jokesList.isNotEmpty) {
        jokes = jokesList[0] as Map<String, dynamic>;
      } else {
        jokes = {};
      }
      notifyListeners();
    } else {
      print('Failed to load jokes ${response.statusCode} ${response.body}');
    }
  }
}
