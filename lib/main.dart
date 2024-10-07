// ignore_for_file: prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'services/books_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca de Livros OpenLibrary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookSearchScreen(),
    );
  }
}

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final BooksApi _booksApi = BooksApi();
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _bookData;
  bool _isLoading = false;

  Future<void> _searchBook() async {
    setState(() {
      _isLoading = true;
    });

    final data = await _booksApi.fetchBook(_searchController.text, limit: 10); // Limita a busca a 10 resultados
    setState(() {
      _bookData = data;
      _isLoading = false;
    });
  }

  String _getCoverUrl(Map<String, dynamic> book) {
    if (book['cover_i'] != null) {
      return 'https://covers.openlibrary.org/b/id/${book['cover_i']}-L.jpg';
    } else if (book['isbn'] != null && (book['isbn'] as List).isNotEmpty) {
      return 'https://covers.openlibrary.org/b/isbn/${book['isbn'][0]}-L.jpg';
    }
    return ''; 
  }

  String _getValidData(dynamic data) {
    return data != null ? data.toString() : 'N/A';
  }

  bool _isValidBook(Map<String, dynamic> book) {
    return
      book['title'] != null &&
      book['author_name'] != null &&
      book['publisher'] != null &&
      book['first_publish_year'] != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca de Livros OpenLibrary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Pesquise por um livro',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchBook,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_bookData != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _bookData!['docs'].length,
                  itemBuilder: (context, index) {
                    final book = _bookData!['docs'][index];

                    if (!_isValidBook(book)) {
                      return const SizedBox.shrink();
                    }

                    final coverUrl = _getCoverUrl(book);

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Título: ${_getValidData(book['title'])}',
                              style: const TextStyle( fontWeight: FontWeight.bold)),
                            Text('Autores: ${_getValidData((book['author_name'] as List?)?.join(', '))}'),
                            Text('Editora: ${_getValidData((book['publisher'] as List?)?.first)}'),
                            Text('Data de publicação: ${_getValidData(book['first_publish_year'])}'),
                            Text('Número de páginas: ${_getValidData(book['number_of_pages_median'])}'),
                            Text('ISBN: ${_getValidData((book['isbn'] as List?)?.first)}'),
                            const SizedBox(height: 10),

                            Image.network(
                              coverUrl.isNotEmpty ? coverUrl : 'assets/images/placeholder_cover.png',
                              height: 150,
                              width: 100,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {

                                return Image.asset(
                                  'assets/images/placeholder_cover.png',
                                  height: 150,
                                  width: 100,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Text('Nenhum resultado encontrado'),
          ],
        ),
      ),
    );
  }
}
