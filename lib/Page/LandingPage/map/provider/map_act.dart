// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class MapAction extends ChangeNotifier {
  PositionModel? source;
  bool isSourcePinned, isDestinationPinned;
  PositionModel? destination;
  MapsProvider mapsProvider;

  MapAction({
    required this.mapsProvider,
    this.source,
    this.destination,
    this.isSourcePinned = false,
    this.isDestinationPinned = false,
  });

  onLocationChanged(LocationData? currentLocation);

  Future<void> getPolyPoints() async {
    try {
      if (destination != null) {
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          Constants.googleApiKey,
          PointLatLng(source!.latitude!, source!.longitude!),
          PointLatLng(destination!.latitude!, destination!.longitude!),
          travelMode: TravelMode.walking,
        );
        mapsProvider.polylineCoordinates = [];
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            mapsProvider.polylineCoordinates
                .add(LatLng(point.latitude, point.longitude));
          }
        }
      } else {
        mapsProvider.polylineCoordinates = [];
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
