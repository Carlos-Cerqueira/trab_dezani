// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('O Pequeno Príncipe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Autor: Antoine de Saint-Exupéry'),
            Text('Páginas: 96'),
            Text('Ano: 1943'),
            SizedBox(height: 20),
            Text('Sinopse: Um piloto cai com seu avião no deserto e ali encontra um príncipe vindo de um planeta distante. O livro aborda temas como solidão, amizade e perda.'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFD5E8D4),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/icons/iconBack.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/iconChecklist.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/lists');
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/iconHome.png',
                width: 45,
                height: 45,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/iconUser.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/iconGo.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/current'); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
