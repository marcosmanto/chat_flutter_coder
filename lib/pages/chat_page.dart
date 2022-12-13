import 'package:chat_flutter_coder/components/messages.dart';
import 'package:chat_flutter_coder/components/new_message.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_service.dart';
import 'package:chat_flutter_coder/core/services/notifications/push_notification_service.dart';
import 'package:chat_flutter_coder/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
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
              ),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.red[800],
                    maxRadius: 10,
                    child: Text(
                      '${Provider.of<PushNotificationService>(context).itemCount}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
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
