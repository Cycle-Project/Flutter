import 'package:geo_app/Client/Models/GoogleMaps/Elevation/elevation_model.dart';

class GoogleMapsBasicElevationModel {
  List<ElevationModel>? elevationList;

  GoogleMapsBasicElevationModel({this.elevationList});

  GoogleMapsBasicElevationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      elevationList = <ElevationModel>[];
      json['results'].forEach((v) {
        elevationList!.add(ElevationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (elevationList != null) {
      data['rows'] = elevationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

