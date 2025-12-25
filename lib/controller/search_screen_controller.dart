import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class SearchScreenController with ChangeNotifier {
  NewsModel? newsModel;
  bool isLoading = false;

  Future<void> searchData({required String searchText}) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://newsapi.org/v2/everything?q=$searchText&apiKey=2533294f67bb454491f5c583850e44d4");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        newsModel = NewsModel.fromJson(decodedData);
      } else {
        print("Api failed");
        // Handle the failure case as needed.
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case as needed.
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}