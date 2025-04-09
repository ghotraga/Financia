import 'package:financia/pages/main_loginpage.dart';
import 'package:flutter/material.dart';
import 'package:financia/pages/main_contentpage.dart';
import 'package:financia/pages/main_homepage.dart';
import 'package:financia/pages/main_userprofilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      home: const MyHomePage(title: 'Home Page', userProfile: {}),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.userProfile});

  final String title;
  final Map<String, dynamic> userProfile;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _checkUserProfile();
  }

  void _checkUserProfile() {
    // If the user profile is empty, show the login page
    if (widget.userProfile.isEmpty) {
      _showLoginPage();
    }
  }

  void _showLoginPage() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ContentPage(),
      HomePage(userProfile: {},),
      UserProfilePage(userProfile: widget.userProfile),
    ];

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Welcome, ${widget.userProfile['name'] ?? 'Guest'}!'),
        backgroundColor: Colors.orangeAccent,
      ),*/
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Content',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}