import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class VisitingBankPage extends StatefulWidget {
  const VisitingBankPage({super.key});

  @override
  State<VisitingBankPage> createState() => _VisitingBankPageState();
}

class _VisitingBankPageState extends State<VisitingBankPage> {
  LatLng? _currentLocation;
  final List<Marker> _bankMarkers = [];
  String? _errorMessage; // To store error messages

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Please enable location services to use this feature.';
        });
        return;
      }

      // Check for location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permissions if denied
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

      // Get the user's current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _errorMessage = null; // Clear any previous error messages
      });

      // Load nearby banks after setting the current location
      _loadNearbyBanks();
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while fetching your location: $e';
      });
    }
  }

  void _loadNearbyBanks() {
    if (_currentLocation == null) return;

    // Example bank markers (replace with dynamic data if needed)
    _bankMarkers.addAll([
      Marker(
        point: LatLng(_currentLocation!.latitude + 0.01, _currentLocation!.longitude),
        width: 40,
        height: 40,
        child: Icon(Icons.location_on, color: Colors.red),
      ),
      Marker(
        point: LatLng(_currentLocation!.latitude - 0.01, _currentLocation!.longitude),
        width: 40,
        height: 40,
        child: Icon(Icons.location_on, color: Colors.red),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visiting a Bank',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentLocation ?? LatLng(0, 0),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        // User's current location marker
                        Marker(
                          point: _currentLocation!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                          ),
                        ),
                        // Bank markers
                        ..._bankMarkers,
                      ],
                    ),
                  ],
                ),
    );
  }
}