import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/distance_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/duration_model.dart';

class ElementsModel {
  DistanceModel? distance;
  DurationModel? duration;

  ElementsModel({this.distance, this.duration});

  ElementsModel.fromJson(Map<String, dynamic> json) {
    distance = DistanceModel.fromJson(json['distance']);
    duration = DurationModel.fromJson(json['duration']);
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