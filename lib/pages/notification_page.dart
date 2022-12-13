import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Minhas notificações',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('Notificações'),
      ),
    );
  }
}
