import 'dart:io' as io;

import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'package:chat_flutter_coder/pages/auth_page.dart';
import 'package:chat_flutter_coder/pages/chat_page.dart';
import 'package:chat_flutter_coder/pages/loading_page.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatUser?>(
      stream: AuthService().userChanges,
      builder: (context, snapshot) => Scaffold(
        /*appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 65,
          leading: Align(
            child: Transform.translate(
              offset: const Offset(15, 0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: (() {
                    if (snapshot.data?.imageURL != null &&
                        snapshot.data?.imageURL != '') {
                      try {
                        return (io.File(snapshot.data!.imageURL).existsSync()
                                ? FileImage(io.File(snapshot.data!.imageURL))
                                : AssetImage(snapshot.data!.imageURL))
                            as ImageProvider;
                      } catch (_) {
                        return null;
                      }
                    }
                  })(),
                ),
              ),
            ),
          ),
          title: Text(
            snapshot.data?.name ?? 'Not logged',
            style: const TextStyle(color: Colors.white),
          ),
        ),*/
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
        stream: AuthService().userChanges,
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