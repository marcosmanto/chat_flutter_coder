import 'dart:async';

import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:chat_flutter_coder/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });

    /*return Stream<List<ChatMessage>>.multi((controller) {
      snapshots.listen((snapshot) {
        for (final doc in snapshot.docs) {
          List<ChatMessage> chatMessageList =
              snapshot.docs.map((doc) => doc.data()).toList();
          controller.add(chatMessageList);
        }
      });
    });*/
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageURL,
    );

    final store = FirebaseFirestore.instance;
    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(newMessage);

    return (await docRef.get()).data();
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    /*return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
    );*/
    return ChatMessage.fromMap({'id': doc.id, ...doc.data()!});
  }

  Map<String, Object?> _toFirestore(
      ChatMessage? chatMessage, SetOptions? options) {
    return chatMessage!.toMap();
  }
}
