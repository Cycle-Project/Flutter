import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/distance_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/duration_model.dart';

class GMElements {
  GMDistance? distance;
  GMDuration? duration;

  GMElements({this.distance, this.duration});

  GMElements.fromJson(Map<String, dynamic> json) {
    distance = GMDistance.fromJson(json['distance']);
    duration = GMDuration.fromJson(json['duration']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    return data;
  }
}
