import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_mock_service.dart';
import 'package:chat_flutter_coder/pages/auth_page.dart';
import 'package:chat_flutter_coder/pages/chat_page.dart';
import 'package:chat_flutter_coder/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatUser?>(
      stream: AuthMockService().userChanges,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text(
            snapshot.data?.name ?? 'Not logged',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: snapshot.connectionState == ConnectionState.waiting
            ? const LoadingPage()
            : snapshot.hasData
                ? const ChatPage()
                : const AuthPage(),
      ),
    );
  }
}


/*

import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_mock_service.dart';
import 'package:chat_flutter_coder/pages/auth_page.dart';
import 'package:chat_flutter_coder/pages/chat_page.dart';
import 'package:chat_flutter_coder/pages/loading_page.dart';
import 'package:flutter/material.dart';
class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Auth or Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
*/