// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'views/app.dart';

const options = FirebaseOptions(
  apiKey: "AIzaSyCKao86Dwe9S9iJv5CH4HYnlK444N7w8Uo",
  authDomain: "app-ratebooks.firebaseapp.com",
  projectId: "app-ratebooks",
  storageBucket: "app-ratebooks.firebasestorage.app",
  messagingSenderId: "553594413263",
  appId: "1:553594413263:web:e12a27b4d4eca7ba3c97ba",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: options);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Permissões de notificação concedidas");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("Permissões provisórias concedidas");
  } else {
    print("Permissões de notificação não concedidas");
  }

  runApp(RateBooksApp());
}