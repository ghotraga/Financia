import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Financia'),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),*/
      body: const Center(
        child: Text(
          'User Profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}