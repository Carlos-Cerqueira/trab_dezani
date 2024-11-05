// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/textField.dart';
import 'components/bottomNavigationBar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  late User? currentUser;
  late String userId;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser!.uid;
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        nomeController.text = userData['nome'] ?? '';
        sobrenomeController.text = userData['sobrenome'] ?? '';
        emailController.text = userData['email'] ?? '';
        passwordController.text = userData['senha'] ?? '';
      }
    } catch (e) {
      print("Erro ao carregar dados do usuário: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5E8D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5E8D4),
        elevation: 0,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFDFF0D8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Edite seu Perfil',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3D3737),
                  ),
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE63946),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Editar Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }
}
