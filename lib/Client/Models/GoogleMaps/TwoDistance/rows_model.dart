import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/elements_model.dart';

class RowsModel {
  List<ElementsModel>? elements;

  RowsModel({this.elements});

  RowsModel.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <ElementsModel>[];
      json['elements'].forEach((v) {
        elements!.add(ElementsModel.fromJson(v));
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
