import 'package:flutter/material.dart';

class NewTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Tab Page'),
      ),
      body: Center(
        child: Text('This is the new tab page.'),
      ),
    );
  }
}
