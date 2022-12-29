import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteModel {
  LatLng? startLocation;
  LatLng? destination;

  RouteModel({
    required this.startLocation,
    required this.destination,
  });
}