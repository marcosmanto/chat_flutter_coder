import 'package:chat_flutter_coder/components/message_bubble.dart';
import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_service.dart';
import 'package:chat_flutter_coder/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final ScrollController _controller = ScrollController();
  final bool _showScrollDownButton = true;

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1350),
      curve: Curves.easeOutExpo,
    );
  }

  // ignore: unused_element
  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'FECHAR',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ));
  }

  void listenScrolling() {
    /*if (_controller.position.atEdge) {
      final isTop = _controller.position.pixels == 0;

      if (isTop) {
        _showSnackBar('Reached Start');
      } else {
        _showSnackBar('Reached End');
      }
    }*/
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(listenScrolling);
  }

  Widget _renderListView(msgs, currentUser) {
    Future(_scrollDown);
    return Stack(
      children: [
        ListView.builder(
          //reverse: true,
          controller: _controller,
          itemCount: msgs.length,
          itemBuilder: (context, index) => MessageBubble(
            key: ValueKey(msgs[index].id),
            message: msgs[index],
            belongsToCurrentUser: currentUser?.id == msgs[index].userId,
          ),
        ),
        if (_showScrollDownButton) ...[
          Positioned(
            top: 5,
            right: 5,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Positioned(
            top: -6.7,
            right: -7.5,
            child: IconButton(
              iconSize: 16,
              onPressed: _scrollDown,
              icon: const Icon(Icons.arrow_downward),
              color: Colors.white,
            ),
          )
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    //Future(_scrollDown);

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem dados. Inicie uma conversa.'),
          );
        } else {
          final msgs = snapshot.data!;
          //.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return _renderListView(msgs, currentUser);
        }
      },
    );
  }
}
