// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: Padding(
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
    );
  }
}
