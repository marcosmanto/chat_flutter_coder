import 'package:chat_flutter_coder/components/messages.dart';
import 'package:chat_flutter_coder/components/new_message.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            DropdownButton(
              iconEnabledColor: Colors.white,
              underline: Container(
                height: 0,
              ),
              icon: const Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: SizedBox(
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.exit_to_app),
                        Text('Sair'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        )));
  }
}
