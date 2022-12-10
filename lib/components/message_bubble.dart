import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble(
      {super.key, required this.message, required this.belongsToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
            width: 180,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text(
                  message.userName,
                  style: TextStyle(
                    color: belongsToCurrentUser ? Colors.black : Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(message.text),
              ],
            )),
      ],
    );
  }
}
