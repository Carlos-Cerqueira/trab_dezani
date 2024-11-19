// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'book_page.dart';
import 'lists_page.dart';
import 'profile_page.dart';
import 'notifications_page.dart';

class RateBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/book": (context) {
          final bookData = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
          return BookPage(bookData: bookData);
        },
        "/lists": (context) => ListsPage(),
        "/profile": (context) => ProfilePage(),
        "/notifications": (context) => NotificationsPage(),
      },
      initialRoute: "/splash",
    );
  }
}
