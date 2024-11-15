// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_super_parameters, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'components/bottomNavigationBar.dart';

class BookPage extends StatefulWidget {
  final Map<String, Object> bookData;

  const BookPage({Key? key, required this.bookData}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;
  double _averageRating = 0.0;
  int _ratingCount = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchAverageRating();
  }

  Future<void> _fetchAverageRating() async {
    final snapshot = await _firestore
        .collection('books')
        .doc(widget.bookData['isbn'] as String?)
        .collection('reviews')
        .get();
    if (snapshot.docs.isNotEmpty) {
      final ratings = snapshot.docs.map((doc) => doc['rating'] as double).toList();
      setState(() {
        _averageRating = double.parse((ratings.reduce((a, b) => a + b) / ratings.length).toStringAsFixed(1));
        _ratingCount = ratings.length;
      });
    }
  }

Future<void> _submitReview() async {
  final user = _auth.currentUser;
  if (user != null && _commentController.text.isNotEmpty) {

    final reviewSnapshot = await _firestore
        .collection('books')
        .doc(widget.bookData['isbn'] as String?)
        .collection('reviews')
        .where('userId', isEqualTo: user.uid)
        .get();
      
    if (reviewSnapshot.docs.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Você já comentou nesse livro."),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    String nomeUsuario;
    if (userDoc.exists) {
      nomeUsuario = userDoc.data()?['nome'];
    } else {
      nomeUsuario = 'Indisponível';
    }
    
    final reviewData = {
      'userId': user.uid,
      'username': nomeUsuario,
      'comment': _commentController.text,
      'rating': _rating,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('books')
        .doc(widget.bookData['isbn'] as String?)
        .collection('reviews')
        .add(reviewData);

    final userAvaliadosCollection = _firestore.collection('users').doc(user.uid).collection('Avaliados');
    final bookSnapshot = await userAvaliadosCollection.where('isbn', isEqualTo: widget.bookData['isbn']).get();

    if (bookSnapshot.docs.isEmpty) {
      await userAvaliadosCollection.add(widget.bookData);
    }

    _fetchAverageRating();
    setState(() {
      _commentController.clear();
      _rating = 0.0;
    });
  }
}

  Future<void> _addToList(String listName) async {
    final user = _auth.currentUser;
    print(user);
    if (user != null) {
      final userBooksCollection = _firestore.collection('users').doc(user.uid).collection(listName);
      final bookSnapshot = await userBooksCollection.where('isbn', isEqualTo: widget.bookData['isbn']).get();
      if (bookSnapshot.docs.isEmpty) {
        await userBooksCollection.add(widget.bookData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        width: double.infinity,
        color: const Color(0xFFDFF0D8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  widget.bookData['coverUrl'] as String? ?? 'assets/images/placeholder_cover.png',
                  height: 200,
                  width: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder_cover.png',
                      height: 200,
                      width: 150,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.bookData['title'] as String? ?? 'Título não disponível',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                widget.bookData['author_name'] as String? ?? 'Autor não disponível',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.bookData['pages'] ?? 'Quantia de páginas não disponível'} páginas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    '$_averageRating ' + '⭐' * _averageRating.floor() + ' ($_ratingCount avaliações)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    'Publicado em ${widget.bookData['first_publish_year']?.toString() ?? 'ano indisponível'}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Descrição do livro: ' + (widget.bookData['description'] as String? ?? 'Descrição não disponível'),
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Selecione a lista para adicionar o livro:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _addToList('Lendo'),
                    child: Text('Lendo'),
                  ),
                  ElevatedButton(
                    onPressed: () => _addToList('Lidos'),
                    child: Text('Lidos'),
                  ),
                  ElevatedButton(
                    onPressed: () => _addToList('Quero Ler'),
                    child: Text('Quero Ler'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Avaliações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('books').doc(widget.bookData['isbn'] as String?).collection('reviews').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final reviews = snapshot.data!.docs;
                  return Column(
                    children: reviews.map((doc) {
                      final review = doc.data() as Map<String, dynamic>;
                      return _buildReview(review['username'], review['comment'], review['rating']);
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Deixe sua avaliação:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Escreva seu comentário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitReview,
                child: Text('Enviar Avaliação'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }

  Widget _buildReview(String username, String comment, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.account_circle, size: 40, color: Colors.grey[700]),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  '$rating ' + '⭐' * rating.floor(),
                  style: TextStyle(fontSize: 14, color: Colors.amber[700]),
                ),
                SizedBox(height: 4),
                Text(
                  comment,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}