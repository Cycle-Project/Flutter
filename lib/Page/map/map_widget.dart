import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/GPS/location_service.dart';
import 'package:geo_app/Page/GPS/position_model.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapWidget extends HookWidget {
  MapWidget({Key? key}) : super(key: key);
  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    final currentMapType = useState(MapType.normal);
    final currentLocation = useState<LocationData?>(null);
    final sourceLocation = useState<PositionModel?>(null);
    final destination = useState<PositionModel?>(null);
    final polylineCoordinates = useState(<LatLng>[]);

    getCurrentLocation() async {
      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation.value?.latitude ?? 0,
              currentLocation.value?.longitude ?? 0,
            ),
            zoom: 16,
          ),
        ),
      );
    }

    getPolyPoints() async {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.value!.latitude!, sourceLocation.value!.longitude!),
        PointLatLng(destination.value!.latitude!, destination.value!.longitude!),
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.value.add(LatLng(point.latitude, point.longitude));
        }
      }
    }

    useEffect(() {
      Future.microtask(() async => await getCurrentLocation());
      location.onLocationChanged.listen((event) {
        currentLocation.value = event;
      });
      return () {};
    }, []);

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(0, 0),
        zoom: 16,
      ),
      mapType: currentMapType.value,
      onMapCreated: (mc) => _controller.complete(mc),
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
            currentLocation.value!.latitude!,
            currentLocation.value!.longitude!,
          ),
          icon: currentLocationIcon,
        ),
        if (sourceLocation.value != null)
          Marker(
            markerId: const MarkerId("sourceLocation"),
            position: LatLng(
              sourceLocation.value!.latitude!,
              sourceLocation.value!.longitude!,
            ),
            icon: sourceIcon,
          ),
        if (destination.value != null)
          Marker(
            markerId: const MarkerId("destination"),
            position: LatLng(
              destination.value!.latitude!,
              destination.value!.longitude!,
            ),
            icon: destinationIcon,
          ),
      },
      polylines: {
        if (polylineCoordinates.value.isNotEmpty)
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates.value,
            color: Colors.red,
            width: 10,
          ),
      },
    );
  }
}
