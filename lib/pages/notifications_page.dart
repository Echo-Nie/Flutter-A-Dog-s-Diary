import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.primaryColor,
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text('通知 ${index + 1}'),
            subtitle: Text('这是一条通知消息的详细内容 ${index + 1}'),
            trailing: Text('${DateTime.now().subtract(Duration(days: index)).month}月${DateTime.now().subtract(Duration(days: index)).day}日'),
          );
        },
      ),
    );
  }
} 