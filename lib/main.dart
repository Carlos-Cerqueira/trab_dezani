import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'views/app.dart';

const options = FirebaseOptions(
  apiKey: "AIzaSyBOSnVY2RCw5A_0a7t0L8S6-TBxKqSH_F4",
  authDomain: "chat-fatec-a9602.firebaseapp.com",
  projectId: "chat-fatec-a9602",
  storageBucket: "chat-fatec-a9602.appspot.com",
  messagingSenderId: "131429510869",
  appId: "1:131429510869:web:8fd503b910c75102163c5c",
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: options);
  runApp(RateBooksApp());
}