// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/textField.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFFDFF0D8),
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: 80,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: emailController,
              label: 'E-mail',
              iconPath: 'assets/icons/iconEmail.png',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              label: 'Senha',
              iconPath: 'assets/icons/iconSenha.png',
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;

                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  print("Usuário logado com sucesso: ${userCredential.user!.uid}");
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  print("Erro ao fazer login: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erro ao fazer login: $e")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE63946),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  color: const Color(0xFF3D3737),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF3D3737),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
