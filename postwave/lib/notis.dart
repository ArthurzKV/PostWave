import 'package:flutter/material.dart';
import 'package:postwave/Postwave_feed.dart';
import 'package:postwave/profile.dart'; // Assuming PostwaveFeedPage is in profile.dart

Color selectedColor = Colors.purple; // Color for the selected item
Color unselectedColor = Colors.black; // Color for unselected items

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Pedro_Alcantara le gustó tu publicación',
    'Pedro_Alcantara comentó en tu publicación',
    'Pedro_Alcantara comenzó a seguirte',
    // Hay q agregar mas notis despues
  ];

  void navigateToHome(BuildContext context) {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostwaveFeedPage()),
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTabPage()),
    );
  }

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
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1626301688449-1fa324d15bca?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace this with the URL of the user's image
            ),
            title: Text(notifications[index]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // No need for GestureDetector
            label: 'Notificaciones',
          ),
        ],
        currentIndex: 2, // Set the initial selected item to 0 (Home)
        onTap: (int index) {
          switch (index) {
            case 0:
              navigateToHome(context);
              break;
            case 1:
              navigateToProfile(context);
              break;
          }
        },
      ),
    );
  }
}
