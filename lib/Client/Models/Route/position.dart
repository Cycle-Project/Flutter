class Position {
  String? latitude;
  String? longitude;
  String? altitude;
  String? city;

  Position({this.latitude, this.longitude, this.altitude, this.city});

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
}
