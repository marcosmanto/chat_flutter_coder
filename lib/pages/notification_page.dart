import 'package:chat_flutter_coder/core/services/notifications/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PushNotificationService service = Provider.of(context);
    final items = service.items;
    final itemCount = service.itemCount;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Minhas notificações',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: itemCount > 0
          ? ListView.separated(
              itemCount: service.itemCount,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: Icon(
                    Icons.remove_circle_sharp,
                    color: Colors.red[800],
                  ),
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                  onTap: () => service.remove(index),
                );
              },
            )
          : const Center(child: Text('Não existem mensagens para você.')),
    );
  }
}
