// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geo_app/GPS/location_service.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates;
  MapAction? mapAction;

  MapsProvider({
    this.currentLocation,
    this.polylineCoordinates = const [],
  });

  StreamSubscription<LocationData> listenLocation() {
    return location.onLocationChanged.listen((event) async {
      currentLocation = event;
      mapAction?.onLocationChanged(currentLocation);
      notifyListeners();
    });
  }
}
