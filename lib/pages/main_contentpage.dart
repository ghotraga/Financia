import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Financia'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),*/
      body: const Center(
        child: Text(
          'Content Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}