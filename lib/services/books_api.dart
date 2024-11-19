// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksApi {
  final String baseUrl = 'https://openlibrary.org/search.json?q=';

  Future<Map<String, dynamic>?> fetchBook(String query, {int limit = 10}) async {
    final url = Uri.parse('$baseUrl$query&limit=$limit');  
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch book data: ${response.statusCode}');
      return null;
    }
  }
}
