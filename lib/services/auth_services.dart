// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> registerUser({
    required String nome,
    required String sobrenome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return userCredential;
    } catch (e) {
      throw Exception("Erro ao registrar usuário: $e");
    }
  }
}
