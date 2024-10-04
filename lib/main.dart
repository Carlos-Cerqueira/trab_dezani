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
      title: 'Busca de Livros Google',
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

    final data = await _booksApi.fetchBook(_searchController.text);
    setState(() {
      _bookData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca de Livros Google'),
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
                  itemCount: _bookData!['items'].length,
                  itemBuilder: (context, index) {
                    final book = _bookData!['items'][index]['volumeInfo'];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Título: ${book['title'] ?? 'N/A'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Subtítulo: ${book['subtitle'] ?? 'N/A'}'),
                            Text('Autores: ${(book['authors'] as List?)?.join(', ') ?? 'N/A'}'),
                            Text('Editora: ${book['publisher'] ?? 'N/A'}'),
                            Text('Data de publicação: ${book['publishedDate'] ?? 'N/A'}'),
                            Text('Número de páginas: ${book['pageCount']?.toString() ?? 'N/A'}'),
                            Text('Categorias: ${(book['categories'] as List?)?.join(', ') ?? 'N/A'}'),
                            Text('Idioma: ${book['language'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                            Text('Descrição: ${book['description'] ?? 'Sem descrição disponível'}'),
                            const SizedBox(height: 10),
                            if (book['imageLinks'] != null && book['imageLinks']['thumbnail'] != null)
                              Image.network(
                                book['imageLinks']['thumbnail'],
                                height: 150,
                                width: 100,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const Text('Falha ao carregar imagem');
                                },
                              ),
                            const SizedBox(height: 10),
                            if (book['industryIdentifiers'] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ISBN_10: ${book['industryIdentifiers'][0]['identifier'] ?? 'N/A'}'),
                                  Text('ISBN_13: ${book['industryIdentifiers'].length > 1 ? book['industryIdentifiers'][1]['identifier'] : 'N/A'}'),
                                ],
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
