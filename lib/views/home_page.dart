// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RateBooks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Procure um livro!',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text('Nada por aqui! Tente pesquisar algum livro.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEBD8BE),
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
