// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'components/bottomNavigationBar.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0D8),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Lendo'),
              _buildBookList(),
              SizedBox(height: 20),
              _buildSectionTitle('Lidos'),
              _buildBookList(),
              SizedBox(height: 20),
              _buildSectionTitle('Quero Ler'),
              _buildBookList(),
              SizedBox(height: 20),
              _buildSectionTitle('Avaliados'),
              _buildBookList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildBookList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: AssetImage('assets/images/placeholder_cover.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'O Pequeno Príncipe',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

