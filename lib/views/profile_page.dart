// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/textField.dart';
import 'components/bottomNavigationBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future<void> _updateUserData() async {
    if (passwordController.text != confirmPasswordController.text) {
      print("As senhas não coincidem!");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'nome': nomeController.text,
        'sobrenome': sobrenomeController.text,
        'email': emailController.text,
        'senha': passwordController.text,
      });

      if (currentUser != null && currentUser!.email != emailController.text) {
        await currentUser!.verifyBeforeUpdateEmail(emailController.text);
      }

      if (passwordController.text.isNotEmpty) {
        await currentUser!.updatePassword(passwordController.text);
      }

      print("Dados do usuário atualizados com sucesso!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dados atualizados com sucesso!")),
      );
    } catch (e) {
      print("Erro ao atualizar os dados do usuário: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar os dados do usuário")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6E3CF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6E3CF),
        elevation: 0,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF6E3CF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Edite seu Perfil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3D3737),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
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
                    Center(
                      child: ElevatedButton(
                        onPressed: _updateUserData,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }
}
