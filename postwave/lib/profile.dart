import 'package:flutter/material.dart';

class NewTabPage extends StatefulWidget {
  const NewTabPage({Key? key}) : super(key: key);

  @override
  State<NewTabPage> createState() => _NewTabPageState();
}

class _NewTabPageState extends State<NewTabPage> {
  String userName = 'tu_nombre_usuario';
  String profilePicUrl =
      'https://placehold.it/150'; // Imagen de marcador de posición
  int followerCount = 0;
  int followingCount = 0;
  int postCount = 0;

  // Función para construir una tarjeta de estadísticas
  Widget buildStatCard({required int count, required String label}) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
              context), // Manejar la pulsación del botón de retroceso
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilePicUrl),
              radius: 50.0, // Ajustar el radio según sea necesario
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildStatCard(count: followerCount, label: 'Seguidores'),
              buildStatCard(count: followingCount, label: 'Siguiendo'),
              buildStatCard(count: postCount, label: 'Publicaciones'),
            ],
          ),
          // Implementar la sección de publicaciones aquí
          // ... (código para mostrar publicaciones)
        ],
      ),
    );
  }
}
