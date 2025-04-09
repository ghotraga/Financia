import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:financia/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  final String _auth0Domain = 'dev-y8kzi2o4.us.auth0.com';
  final String _auth0ClientId = 'EhfYFk1e3kpMUMg0w1EYeBTmZykPov34';
  final String _auth0RedirectUri = 'com.auth0.flutter://login-callback';
  final String _auth0Issuer = 'https://dev-y8kzi2o4.us.auth0.com';

  String? _accessToken;
  String? _idToken;
  Map<String, dynamic>? _userProfile;

  Future<void> _login() async {
    try {
      print('Starting login...');
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _auth0ClientId,
          _auth0RedirectUri,
          issuer: _auth0Issuer,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result != null) {
        print('Login successful!');
        print('Access Token: ${result.accessToken}');
        print('ID Token: ${result.idToken}');
        setState(() {
          _accessToken = result.accessToken;
          _idToken = result.idToken;
        });

        // Fetch user profile
        await _fetchUserProfile();

        // Navigate to the main home page and pass the user profile
        if (_userProfile != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                title: 'Home Page',
                userProfile: _userProfile!,
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Future<void> _fetchUserProfile() async {
    final url = Uri.parse('https://$_auth0Domain/userinfo');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _userProfile = json.decode(response.body);
      });
    } else {
      print('Failed to fetch user profile: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: _userProfile == null
            ? ElevatedButton(
                onPressed: _login,
                child: const Text('Login with Auth0'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_userProfile!['name']}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _userProfile = null;
                        _accessToken = null;
                        _idToken = null;
                      });
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
      ),
    );
  }
}