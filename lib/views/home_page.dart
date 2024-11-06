// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/books_api.dart';

import 'components/bottomNavigationBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BooksApi _booksApi = BooksApi(
    
  );
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _bookData;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _searchBook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final data = await _booksApi.fetchBook(_searchController.text, limit: 10);

    if (data != null && data['docs'] != null) {
      setState(() {
        _bookData = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Nenhum resultado encontrado. Tente outra pesquisa.';
        _isLoading = false;
      });
    }
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
    return book['title'] != null &&
        book['author_name'] != null &&
        book['publisher'] != null &&
        book['first_publish_year'] != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6E3CF),
        title: Row(
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: 40,
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF6E3CF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Pesquise por um livro',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.search),
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
              else if (_errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (_bookData != null && _bookData!['docs'] != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: _bookData!['docs'].length,
                    itemBuilder: (context, index) {
                      final book = _bookData!['docs'][index];

                      if (!_isValidBook(book)) {
                        return const SizedBox.shrink();
                      }

                      final coverUrl = _getCoverUrl(book);

                      return GestureDetector(
                        onTap: () {
                          var books = {
                            'title': _getValidData(book['title']),
                            'pages': _getValidData(book['number_of_pages_median']),
                            'author_name': _getValidData(
                                (book['author_name'] is List)
                                    ? (book['author_name'] as List).join(', ')
                                    : book['author_name']),
                            'publisher': _getValidData(
                                (book['publisher'] is List)
                                    ? (book['publisher'] as List).first
                                    : book['publisher']),
                            'first_publish_year':
                                _getValidData(book['first_publish_year']),
                            'isbn': _getValidData((book['isbn'] is List)
                                ? (book['isbn'] as List).first
                                : book['isbn']),
                            'coverUrl': coverUrl,
                            'categorie': (book['categories'] is List &&
                                    (book['categories'] as List).isNotEmpty)
                                ? (book['categories'] as List).join(', ')
                                : 'Categoria não disponível.',
                            'description': _getValidData(book['description']),
                          };

                          Navigator.pushNamed(
                            context,
                            '/book',
                            arguments: books,
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  coverUrl.isNotEmpty
                                      ? coverUrl
                                      : 'assets/images/placeholder_cover.png',
                                  height: 150,
                                  width: 100,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/images/placeholder_cover.png',
                                      height: 150,
                                      width: 100,
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Título: ${_getValidData(book['title'])}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Autores: ${_getValidData((book['author_name'] as List?)?.join(', '))}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Editora: ${_getValidData((book['publisher'] as List?)?.first)}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Data de publicação: ${_getValidData(book['first_publish_year'])}',
                                      ),
                                      Text(
                                        'Número de páginas: ${_getValidData(book['number_of_pages_median'])}',
                                      ),
                                      Text(
                                        'ISBN: ${_getValidData((book['isbn'] as List?)?.first)}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Text(
                    'Nenhum resultado encontrado.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }
}