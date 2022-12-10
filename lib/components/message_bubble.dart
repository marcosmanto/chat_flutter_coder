import 'dart:io';

import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble(
      {super.key, required this.message, required this.belongsToCurrentUser});

  Widget _showUserImage(String imageURL, BuildContext context) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains('assets/images')) {
      provider = AssetImage(imageURL);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                width: 180,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: belongsToCurrentUser
                      ? Colors.grey[300]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: belongsToCurrentUser
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: belongsToCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.userName,
                      style: TextStyle(
                        color: belongsToCurrentUser
                            ? Colors.black
                            : Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message.text,
                      textAlign: belongsToCurrentUser
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageUrl, context),
        ),
      ],
    );
  }
}
