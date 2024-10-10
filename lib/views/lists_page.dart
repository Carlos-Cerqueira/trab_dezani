// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5E8D4),
      appBar: AppBar(
        backgroundColor: Color(0xFFD5E8D4),
        title: Text('Minhas Listas'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Lista de Livros Lidos, Quero Ler, etc.'),
        ),
        
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEBD8BE),
        child: Container(
          width: double.infinity,
          height: 70.0,
          decoration: BoxDecoration(
            color: const Color(0xFFEBD8BE),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(
                color: Color(0xFFEBB300),
                width: 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image.asset('assets/icons/iconBack.png'),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/iconChecklist.png'),
                onPressed: () {
                  Navigator.pushNamed(context, '/lists');
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/iconHome.png'),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/iconUser.png'),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/iconGo.png'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/current'); 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
