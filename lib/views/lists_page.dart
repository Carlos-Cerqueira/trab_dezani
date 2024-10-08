// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Listas'),
      ),
      body: Center(
        child: Text('Lista de Livros Lidos, Quero Ler, etc.'),
      ),
    );
  }
}
