// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/GPS/location_service.dart';
import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  bool record;
  LocationData? currentLocation;
  PositionModel? sourceLocation;
  PositionModel? destination;
  List<LatLng> polylineCoordinates;

  MapsProvider({
    this.record = false,
    this.polylineCoordinates = const [],
    this.currentLocation,
    this.sourceLocation,
    this.destination,
  });

  StreamSubscription<LocationData> listenLocation() =>
      location.onLocationChanged.listen((event) {
        currentLocation = event;
        notifyListeners();
      });

  changeRecord() async {
    record = !record;
    if (!record || currentLocation == null) {
      sourceLocation = null;
      destination = null;
      polylineCoordinates = [];
    } else {
      sourceLocation =
          PositionModel.fromLatLng(const LatLng(39.753226, 30.493691));
      destination =
          PositionModel.fromLatLng(const LatLng(39.751031, 30.474830));

      //await getPolyPoints();
    }
    notifyListeners();
  }

  Future<void> getPolyPoints({bool isCurrent = true}) async {
    try {
      if (destination != null) {
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          (isCurrent
              ? PointLatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!)
              : PointLatLng(
                  sourceLocation!.latitude!, sourceLocation!.longitude!)),
          PointLatLng(destination!.latitude!, destination!.longitude!),
        );
        polylineCoordinates = [];
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        }
      } else {
        polylineCoordinates = [];
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> setPoints(LatLng? latLng) async {
    destination = latLng != null ? PositionModel.fromLatLng(latLng) : null;
    await getPolyPoints();
  }
}
