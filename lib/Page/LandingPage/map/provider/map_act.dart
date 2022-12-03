import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class MapAction extends ChangeNotifier {
  PositionModel? sourceLocation;
  PositionModel? destination;
  MapsProvider mapsProvider;

  MapAction({
    required this.mapsProvider,
    this.sourceLocation,
    this.destination,
  });

  onLocationChanged(LocationData? currentLocation);

  Future<void> getPolyPoints({bool isCurrent = true}) async {
    try {
      if (destination != null) {
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          (isCurrent
              ? PointLatLng(
                  mapsProvider.currentLocation!.latitude!,
                  mapsProvider.currentLocation!.longitude!,
                )
              : PointLatLng(
                  sourceLocation!.latitude!, sourceLocation!.longitude!)),
          travelMode: TravelMode.walking,
          PointLatLng(destination!.latitude!, destination!.longitude!),
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
