import 'dart:async';
import 'package:geolocator/geolocator.dart';

/// Location Repository for QUCZO Nearby Shop Discovery
class LocationRepository {
  static final LocationRepository _instance = LocationRepository._internal();
  factory LocationRepository() => _instance;
  LocationRepository._internal();

  String _currentLocation = 'Choose your location';
  bool _hasPermission = false;

  String get currentLocation => _currentLocation;
  bool get hasPermission => _hasPermission;

  void setLocation(String location) {
    if (location.isNotEmpty) {
      _currentLocation = location;
    }
  }

  /// Request location permissions and fetch current position
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    _hasPermission = true;
    try {
      Position position = await Geolocator.getCurrentPosition();
      // Normally we would reverse geocode here, but since it requires another API/plugin,
      // we'll just set it to Coordinates for now, or a mock area.
      _currentLocation = 'Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)}';
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get popular search areas for manual location picker
  Future<List<String>> getPopularLocations() async {
    return const [
      'Anna Nagar, Chennai',
      'T. Nagar, Chennai',
      'Velachery, Chennai',
      'Adyar, Chennai',
      'Koramangala, Bengaluru',
      'Indiranagar, Bengaluru',
      'Madhapur, Hyderabad',
    ];
  }
}

