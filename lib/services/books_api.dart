import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksApi {
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes?q=';

  Future<Map<String, dynamic>?> fetchBook(String query) async {
    final url = Uri.parse('$baseUrl$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch book data: ${response.statusCode}');
      return null;
    }
  }
}
