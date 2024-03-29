// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/googlemaps_two_distance.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class GoogleMapsController with IGoogleMaps {
  late Client _client;
  late Map _requestMap;

  GoogleMapsController() {
    _client = Client();
    _requestMap = ClientConstants.paths["googleMaps"];
  }

  @override
  Future<GMDistanceBetween> getDistanceTwoLocation({
    required double dlat,
    required double dlong,
    required double slat,
    required double slong,
  }) async {
    try {
      var str = _requestMap["distanceTwoLocate"] +
          "destinations=$dlat, $dlong"
              "&origins=$slat, $slong"
              "&key=${Constants.googleApiKey}";
      final response = await _client.getMethod(str);
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      GMDistanceBetween model = GMDistanceBetween.fromJson(response.data);
      return model;
    } catch (e) {
      print("$e");
    }
    return GMDistanceBetween();
  }

  @override
  Future<GMElevations> getElevation({
    required double latitute,
    required double longtitude,
  }) async {
    try {
      var str = _requestMap["elevation"] +
          "locations=$latitute, $longtitude"
              "&key=${Constants.googleApiKey}";
      final response = await _client.getMethod(str);
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      GMElevations model = GMElevations.fromJson(response.data);
      return model;
    } catch (e) {
      print("$e");
    }
    return GMElevations();
  }
}


//