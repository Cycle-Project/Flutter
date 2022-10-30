import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/Page/GPS/location_service.dart';
import 'package:geo_app/Page/GPS/position_model.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  bool record = false;
  LocationData? currentLocation;
  PositionModel? sourceLocation;
  PositionModel? destination;
  List<LatLng> polylineCoordinates = [];

  MapsProvider() {
    location.onLocationChanged.listen((event) {
      currentLocation = event;
      notifyListeners();
    });
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation!.latitude!, sourceLocation!.longitude!),
      PointLatLng(destination!.latitude!, destination!.longitude!),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    notifyListeners();
  }
}
