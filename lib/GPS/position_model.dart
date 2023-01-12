/*
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PositionModel {
  double? latitude;
  double? longitude;
  double? altitude;
  String? city;

  PositionModel({
    this.latitude = 0,
    this.longitude = 0,
    this.altitude = 0,
    this.city = "",
  });

  PositionModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    city = json['city'];
  }

  PositionModel.fromLocationData(LocationData locationData) {
    latitude = locationData.latitude;
    longitude = locationData.longitude;
    altitude = locationData.altitude;
  }

  PositionModel.fromLatLng(LatLng latLng) {
    latitude = latLng.latitude;
    longitude = latLng.longitude;
  }

  LatLng toLatLng() => LatLng(
        latitude!,
        longitude!,
      );

  PositionModel.middlePoint(PositionModel a, PositionModel b) {
    latitude = a.latitude! + (b.latitude! - a.latitude!) * 0.5;
    longitude = a.longitude! + (b.longitude! - a.longitude!) * 0.5;
  }

  LatLng get latLng {
    return LatLng(
      latitude!,
      longitude!,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "city": city,
    };
  }

  void setFromLocationData(LocationData locationData) => this
    ..latitude = locationData.latitude
    ..longitude = locationData.longitude
    ..altitude = locationData.altitude;
}
*/
