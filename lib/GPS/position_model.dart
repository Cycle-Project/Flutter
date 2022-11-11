import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PositionModel {
  double? latitude;
  double? longitude;
  double? altitude;

  PositionModel({
    this.latitude = 0,
    this.longitude = 0,
    this.altitude = 0,
  });

  PositionModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
    };
  }

  void setFromLocationData(LocationData locationData) => this
    ..latitude = locationData.latitude
    ..longitude = locationData.longitude
    ..altitude = locationData.altitude;
}
