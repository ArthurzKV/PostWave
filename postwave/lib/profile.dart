import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilePicUrl),
              radius: 50.0,
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
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Mostrar 3 imágenes por fila
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: <Widget>[
                Image.network(
                    'https://www.innovasport.com/medias/IS-CV7889-409-1.png?context=bWFzdGVyfGltYWdlc3wxNDE0NzZ8aW1hZ2UvcG5nfGltYWdlcy9oM2UvaDliLzEwMTEwMzI1OTgxMjE0LnBuZ3wzY2YyZWE2MTIzMDg1MjJjMDRlNzYyYzI1MjE2YjQ3ZWJlNzg4N2EyYjJiOTM1Y2RhMDdmYjMxMDdjNzRkOWNh'), // Reemplazar con URLs reales
                Image.network(
                    'https://images.media-arocam.com/BEQdZdY_sZ4U_ogSdnpohfMRRik=/fit-in/1000x1000/W30122/WNY/I5IvmSp2_WNY.png'),
                Image.network('https://url-imagen-3.com'),
                // ... más imágenes según necesitesda
              ],
            ),
          ),
        ],
      ),
    );
  }
}
