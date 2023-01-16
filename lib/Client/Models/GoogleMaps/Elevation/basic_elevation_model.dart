import 'package:geo_app/Client/Models/GoogleMaps/Elevation/elevation_model.dart';

class GMElevations {
  List<GMElevation>? elevationList;

  GMElevations({this.elevationList});

  GMElevations.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      elevationList = <GMElevation>[];
      json['results'].forEach((v) {
        elevationList!.add(GMElevation.fromJson(v));
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
