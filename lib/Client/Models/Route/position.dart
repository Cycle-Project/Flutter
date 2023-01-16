import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Position {
  String? latitude;
  String? longitude;
  String? altitude;
  String? city;

  Position({
    this.latitude,
    this.longitude,
    this.altitude,
    this.city,
  });

  Position.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'city': city,
      };

  Position.fromLocationData(LocationData locationData) {
    latitude = locationData.latitude.toString();
    longitude = locationData.longitude.toString();
    altitude = locationData.altitude.toString();
  }

  Position.fromLatLng(LatLng latLng) {
    latitude = latLng.latitude.toString();
    longitude = latLng.longitude.toString();
  }

  LatLng toLatLng() => LatLng(
        double.parse(latitude!),
        double.parse(longitude!),
      );

  void setFromLocationData(LocationData locationData) => this
    ..latitude = locationData.latitude.toString()
    ..longitude = locationData.longitude.toString()
    ..altitude = locationData.altitude.toString();
}
