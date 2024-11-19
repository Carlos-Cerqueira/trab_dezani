// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters, avoid_print, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/bottomNavigationBar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('users')
                      .doc(_auth.currentUser!.uid)
                      .collection('notifications')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final notifications = snapshot.data!.docs;
                    if (notifications.isEmpty) {
                      return Center(child: Text("Nenhuma notificação."));
                    }
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(
                            notification['title'] ?? 'Notificação',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(notification['message'] ?? ''),
                          trailing: Text(
                            _formatTimestamp(notification['timestamp'] as Timestamp),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context: context),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
