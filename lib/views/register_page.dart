// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names, prefer_final_fields, must_be_immutable, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trab_dezani/services/auth_services.dart';

import 'components/textField.dart';

class RegisterPage extends StatelessWidget {
  bool reqRegister = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AuthServices _authServices = AuthServices();

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
              height: 100,
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nomeController,
                    label: 'Nome',
                    iconPath: 'assets/icons/iconUser.png',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: sobrenomeController,
                    label: 'Sobrenome',
                    iconPath: 'assets/icons/iconUser.png',
                  ),
                  
                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: confirmPasswordController,
                    label: 'Confirmar Senha',
                    iconPath: 'assets/icons/iconSenha.png',
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      RegisterButton();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Voltar ao Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RegisterButton() async {
    if (_formKey.currentState!.validate()) {
      String nome = nomeController.text;
      String sobrenome = sobrenomeController.text;
      String email = emailController.text;
      String senha = passwordController.text;

      try {
        UserCredential userCredential = await _authServices.registerUser(
          nome: nome,
          sobrenome: sobrenome,
          email: email,
          senha: senha,
        );

        String userId = userCredential.user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'nome': nome,
          'sobrenome': sobrenome,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
          SnackBar(content: Text("Usuário registrado com sucesso!")),
        );

        Navigator.pushReplacementNamed(_formKey.currentContext!, '/home');

      } catch (e) {
        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
          SnackBar(content: Text("Erro ao registrar usuário: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        SnackBar(content: Text("Por favor, preencha todos os campos corretamente")),
      );
    }
  }
}
