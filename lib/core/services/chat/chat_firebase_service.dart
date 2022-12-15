import 'dart:async';

import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:chat_flutter_coder/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageURL,
    });

    final doc = await docRef.get();

    return ChatMessage.fromMap({'id': doc.id, ...doc.data()!});
  }
}
