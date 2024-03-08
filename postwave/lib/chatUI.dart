import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _messages.add(ChatMessage(
            message: 'Hola, ¿cómo estás?',
            type: MessageType.receiver,
            dateTime: DateTime.now()));
        _timer?.cancel(); // Detiene el temporizador después de enviar un mensaje
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador al eliminar el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // Elimina el título de la AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/55/e3/e0/55e3e06ff4fb2ec02e06631f818d55d1.jpg.webp'), // Reemplaza 'URL_DE_TU_IMAGEN' con la URL de tu imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(), // Mostrar el encabezado con foto de usuario y nombre de usuario
            SizedBox(height: 8),
            _buildStartTime(), // Mostrar la hora de inicio del chat
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            SizedBox(height: 8),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white.withOpacity(0.5), // Ajusta la opacidad del color de fondo si lo deseas
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://cdn.mos.cms.futurecdn.net/3E6XZEAtuGD2yCDM7UhyXL-1280-80.jpg.webp'), // Reemplaza 'URL_DE_TU_IMAGEN' con la URL de tu imagen de perfil
          ),
          SizedBox(width: 10),
          Text(
            'User2990',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Column(
      crossAxisAlignment: message.type == MessageType.sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.type == MessageType.sender ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: message.type == MessageType.sender ? Colors.white : Colors.black,
            ),
          ),
        ),
        Text(
          '${message.dateTime.hour}:${message.dateTime.minute}', // Cambia el formato de la fecha según tus preferencias
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStartTime() {
    String? firstMessageTime;
    if (_messages.isNotEmpty) {
      final firstMessage = _messages.last;
      firstMessageTime = '${firstMessage.dateTime.hour}:${firstMessage.dateTime.minute}';
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white.withOpacity(0.5), // Ajusta la opacidad del color de fondo si lo deseas
      child: Text(
        '$firstMessageTime', // Cambia el formato de la fecha según tus preferencias
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5), // Ajusta la opacidad del color de fondo si lo deseas
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage(_controller.text);
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(String messageText) {
    if (messageText.trim().isEmpty) return;
    setState(() {
      _messages.insert(0, ChatMessage(message: messageText, type: MessageType.sender, dateTime: DateTime.now()));
      _controller.clear();
    });
  }
}

enum MessageType { sender, receiver }

class ChatMessage {
  final String message;
  final MessageType type;
  final DateTime dateTime;

  ChatMessage({required this.message, required this.type, required this.dateTime});
}
