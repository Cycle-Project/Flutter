import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/rows_model.dart';

class GMDistanceBetween {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<GMRows>? rowsModel;

  GMDistanceBetween({
    this.destinationAddresses,
    this.originAddresses,
    this.rowsModel,
  });

  GMDistanceBetween.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rowsModel = <GMRows>[];
      json['rows'].forEach((v) {
        rowsModel!.add(GMRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destination_addresses'] = destinationAddresses;
    data['origin_addresses'] = originAddresses;
    if (rowsModel != null) {
      data['rows'] = rowsModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
