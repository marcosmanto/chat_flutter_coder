import 'package:chat_flutter_coder/components/message_bubble.dart';
import 'package:chat_flutter_coder/core/models/chat_message.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_service.dart';
import 'package:chat_flutter_coder/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({super.key});

  final ScrollController _controller = ScrollController();
  late final BuildContext _context;

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1350),
      curve: Curves.easeOutExpo,
    );
  }

  void _showSnackBar(String msg, BuildContext context) {
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
    if (_controller.position.atEdge) {
      final isTop = _controller.position.pixels == 0;

      if (isTop) {
        _showSnackBar('Reached Start', _context);
      } else {
        _showSnackBar('Reached End', _context);
      }
    }
  }

  _onInit(BuildContext context) {
    _context = context;
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
        Positioned(
          right: 5,
          child: ElevatedButton(
              onPressed: _scrollDown, child: const Text('Scroll down')),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    //Future(_scrollDown);

    return StatefulWrapper(
      onInit: _onInit(context),
      child: StreamBuilder<List<ChatMessage>>(
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
            return _renderListView(msgs, currentUser);
          }
        },
      ),
    );
  }
}

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Widget child;
  const StatefulWrapper({super.key, this.onInit, required this.child});
  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit!();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
