import 'package:financia/main.dart';
import 'package:financia/pages/main_loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> userProfile;

  const UserProfilePage({super.key, required this.userProfile});

  /*Future<void> _logout(BuildContext context) async {
    const String auth0Domain = 'dev-y8kzi2o4.us.auth0.com';
    const String clientId = 'EhfYFk1e3kpMUMg0w1EYeBTmZykPov34';
    const String returnTo = 'https://dev-y8kzi2o4.us.auth0.com/logout-callback'; // Valid URL

    final logoutUrl =
        'https://$auth0Domain/v2/logout?client_id=$clientId&returnTo=$returnTo';

    try {
      final response = await http.get(Uri.parse(logoutUrl));
      if (response.statusCode == 200) {
        // Navigate back to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print('Failed to log out: ${response.body}');
      }
    } catch (e) {
      print('Logout error: $e');
    }
}*/

Future<void> _logoutAndLogin(BuildContext context) async {
  const String auth0Domain = 'dev-y8kzi2o4.us.auth0.com';
  const String clientId = 'EhfYFk1e3kpMUMg0w1EYeBTmZykPov34';
  const String redirectUri = 'com.auth0.flutter://login-callback';

  try {
    // Clear the session using Auth0's logout endpoint
    final logoutUrl =
        'https://$auth0Domain/v2/logout?client_id=$clientId&returnTo=$redirectUri';

    final response = await http.get(Uri.parse(logoutUrl));
    if (response.statusCode == 200) {
      print('User logged out successfully.');

      // Start a new login session
      final FlutterAppAuth appAuth = FlutterAppAuth();
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUri,
          issuer: 'https://$auth0Domain',
          scopes: ['openid', 'profile', 'email', 'offline_access'],
          additionalParameters: {'prompt': 'login'}, // Force new login
        ),
      );

      if (result != null) {
        print('New session started.');
        print('Access Token: ${result.accessToken}');
        print('ID Token: ${result.idToken}');

        // Navigate to the home page or handle the new session
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'Home Page',
              userProfile: {
                'accessToken': result.accessToken,
                'idToken': result.idToken,
              },
            ),
          ),
        );
      } else {
        print('Failed to start a new session.');
      }
    } else {
      print('Failed to log out: ${response.body}');
    }
  } catch (e) {
    print('Error during logout and login: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.yellowAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userProfile['picture'] != null
                        ? NetworkImage(userProfile['picture'])
                        : null,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userProfile['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Placeholder Labels
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Label 1',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Label 2',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Label 3',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 30, thickness: 1),
                  const Text(
                    'Content Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Payment Options - Beginner'),
                  LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  const Text('Borrowing - Advanced'),
                  LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            // Logout Button
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _logoutAndLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}