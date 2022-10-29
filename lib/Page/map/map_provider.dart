import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  final ValueNotifier<LocationData?> currentLocation;
  final ValueNotifier<LocationData?> sourceLocation;
  final ValueNotifier<LocationData?> destination;
  final ValueNotifier<List<LatLng>> polylineCoordinates;


  MapsProvider({
    required this.currentLocation,
    required this.sourceLocation,
    required this.destination,
    required this.polylineCoordinates,
  });

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.value!.latitude!,
          sourceLocation.value!.longitude!),
      PointLatLng(
          destination.value!.latitude!, destination.value!.longitude!),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.value
            .add(LatLng(point.latitude, point.longitude));
      }
    }
  }
}
