// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF0D8),
      appBar: AppBar(
        backgroundColor: Color(0xFFDFF0D8),
        title: Text('Minhas Listas'),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFDFF0D8),
        child: SingleChildScrollView(
          child: Center(
            child: Text('Lista de Livros Lidos, Quero Ler, etc.'),
          ),
          
        ),
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
