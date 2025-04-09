import 'dart:convert';
import 'package:financia/pages/tools/bank_questionspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class VisitingBankPage extends StatefulWidget {
  const VisitingBankPage({super.key});

  @override
  State<VisitingBankPage> createState() => _VisitingBankPageState();
}

class _VisitingBankPageState extends State<VisitingBankPage> {
  LatLng? _currentLocation;
  final List<Marker> _bankMarkers = [];
  final List<Map<String, String>> _bankList = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Please enable location services to use this feature.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permissions are denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
              'Location permissions are permanently denied. Please enable them in settings.';
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _errorMessage = null;
      });

      _loadNearbyBanks();
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while fetching your location: $e';
      });
    }
  }

  Future<void> _loadNearbyBanks() async {
    if (_currentLocation == null) return;

    final double latitude = _currentLocation!.latitude;
    final double longitude = _currentLocation!.longitude;

    final String overpassQuery = '''
    [out:json];
    node
      [amenity=bank]
      (around:1000, $latitude, $longitude);
    out;
    ''';

    final Uri url = Uri.parse('https://overpass-api.de/api/interpreter');

    try {
      final response = await http.post(
        url,
        body: {'data': overpassQuery},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> elements = data['elements'];

        setState(() {
          _bankMarkers.clear();
          _bankList.clear();
          for (var element in elements) {
            final double lat = element['lat'];
            final double lon = element['lon'];
            final String name = element['tags']?['name'] ?? 'Unnamed Bank';
            final String address = element['tags']?['addr:street'] ?? 'No Address';

            _bankMarkers.add(
              Marker(
                point: LatLng(lat, lon),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.red),
              ),
            );

            _bankList.add({'name': name, 'address': address});
          }
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch nearby banks. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while fetching nearby banks: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visiting a Bank'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: _currentLocation!,
                          initialZoom: 13.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(markers: _bankMarkers),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: _bankList.length,
                        itemBuilder: (context, index) {
                          final bank = _bankList[index];
                          return ListTile(
                            title: Text(bank['name']!),
                            subtitle: Text(bank['address']!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankQuestionsPage(bankName: bank['name']!),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}