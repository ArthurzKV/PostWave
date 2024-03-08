import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:postwave/Postwave_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notis.dart';

Color selectedColor = Colors.purple; // Color for the selected item
Color unselectedColor = Colors.black; // Color for unselected items

class NewTabPage extends StatefulWidget {
  const NewTabPage({Key? key}) : super(key: key);

  @override
  State<NewTabPage> createState() => _NewTabPageState();
}

class _NewTabPageState extends State<NewTabPage> {
  String userName = 'user09';
  String profilePicUrl =
      'https://images.unsplash.com/photo-1709651483125-dfa559cd920d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Placeholder image
  int followerCount = 1432;
  int followingCount = 23;
  int postCount = 2;

  // Function to build a statistics card
  Widget buildStatCard({required int count, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
            child: Stack(
              // Use Stack to position elements
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(profilePicUrl),
                  radius: 50.0,
                ),
                Positioned(
                  // Position edit button below the avatar
                  bottom: -2.5, // Adjust positioning as needed
                  right: -5.0,
                  child: TextButton(
                    onPressed: () async {
                      final newName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfilePage(currentUserName: userName),
                        ),
                      );
                      if (newName != null) {
                        setState(() {
                          userName = newName;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
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
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Show 3 images per row
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: List.generate(2, (index) {
                // Generate 2 images
                String imageUrl;
                String detailImageUrl;
                if (index == 0) {
                  imageUrl =
                      'https://images.unsplash.com/photo-1709642717827-9621f2a978a1?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
                  detailImageUrl =
                      'https://images.unsplash.com/photo-1709642717827-9621f2a978a1?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
                } else {
                  imageUrl =
                      'https://images.unsplash.com/photo-1709651483125-dfa559cd920d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
                  detailImageUrl =
                      'https://images.unsplash.com/photo-1709651483125-dfa559cd920d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailPage(
                          imageUrl: detailImageUrl,
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover, // Estira la imagen en el grid
                  ),
                );
              }),
            ),
          ),
        ],
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
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(
                    10.0), // Aumenta este valor para aumentar el área de toque
                child: Icon(Icons.notifications),
              ),
            ),
            label: 'Notificaciones',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0: // Inicio item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostwaveFeedPage(),
                ),
              );
              break;
          }
        },
        currentIndex: 1,
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String currentUserName;

  EditProfilePage({required this.currentUserName});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUserName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _nameController.text);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDetailPage extends StatefulWidget {
  final String imageUrl;

  ImageDetailPage({required this.imageUrl});

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la imagen'),
      ),
      body: Column(
        children: [
          Image.network(widget.imageUrl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Handle comment button press
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Handle share button press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}