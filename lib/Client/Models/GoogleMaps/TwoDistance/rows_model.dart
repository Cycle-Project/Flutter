import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/elements_model.dart';

class GMRows {
  List<GMElements>? elements;

  GMRows({this.elements});

  GMRows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <GMElements>[];
      json['elements'].forEach((v) {
        elements!.add(GMElements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
