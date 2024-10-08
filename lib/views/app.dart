// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'start_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'book_page.dart';
import 'lists_page.dart';
import 'profile_page.dart';

class RateBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/start": (context) => StartPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/book": (context) => BookPage(),
        "/lists": (context) => ListsPage(),
        "/profile": (context) => ProfilePage(),
      },
      initialRoute: "/start",
    );
  }
}
