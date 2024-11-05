// ignore_for_file: use_super_parameters, file_names

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BuildContext context;

  const CustomBottomNavigationBar({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/iconBell.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
    );
  }
}