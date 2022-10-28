class PositionModel {
  double? latitude;
  double? longitude;
  double? altitude;

  PositionModel({this.latitude, this.longitude, this.altitude});

  PositionModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
    };
  }
}
