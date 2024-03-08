import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Usuario1 le gustó tu publicación',
    'Usuario2 comentó en tu publicación',
    'Usuario3 comenzó a seguirte',
    // Agrega más notificaciones aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}