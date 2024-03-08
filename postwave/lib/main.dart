import 'package:flutter/material.dart';
import 'Postwave_feed.dart';

// Importa la página del feed de Postwave desde el archivo correspondiente
//penepenepnepne

void main() {
  runApp(PostwaveApp());
}

class PostwaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Postwave',
      theme: ThemeData(
          // Define tu tema aquí
          ),
      home:
          LoginPage(), // Muestra la página de inicio de sesión al iniciar la aplicación
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD0E6F0),
              Color(0xFFA0D4F0)
            ], // Azul claro con gradiente
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Aquí se agrega el logo de Flutter
              FlutterLogo(size: 100),
              SizedBox(height: 20),
              // Aquí se agrega el formulario de inicio de sesión
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    // Lógica de autenticación aquí
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Ejemplo básico de autenticación
    if (username == '' && password == '') {
      // Si las credenciales son correctas, navegamos a la página del feed de Postwave
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PostwaveFeedPage()), // Aquí estamos utilizando la página del feed de Postwave del archivo postwave_feed.dart
      );
    } else {
      // Si las credenciales son incorrectas, mostramos un diálogo de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Nombre de usuario o contraseña incorrectos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Nombre de usuario',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () =>
                _submitForm(context), // Llama a la función _submitForm
            child: Text('Iniciar sesión'),
            style: ElevatedButton.styleFrom(// Color del botón morado
                ),
          ),
        ],
      ),
    );
  }
}
