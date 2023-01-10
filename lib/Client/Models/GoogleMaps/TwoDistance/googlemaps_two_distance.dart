import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/rows_model.dart';

class GoogleMapsTwoDistanceBasicModel {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<RowsModel>? rowsModel;

  GoogleMapsTwoDistanceBasicModel({
    this.destinationAddresses,
    this.originAddresses,
    this.rowsModel,
  });

  GoogleMapsTwoDistanceBasicModel.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rowsModel = <RowsModel>[];
      json['rows'].forEach((v) {
        rowsModel!.add(RowsModel.fromJson(v));
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







