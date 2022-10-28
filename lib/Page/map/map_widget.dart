import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWidget extends HookWidget {
  final LocationData? locationData;

  MapWidget({
    required this.locationData,
    super.key,
  });

  final Completer<GoogleMapController> _controller = Completer();
  MapType currentMapType = MapType.normal;

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  static const LatLng sourceLocation = LatLng(39.753226, 30.493691);
  static const LatLng destination = LatLng(39.751031, 30.474830);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      getCurrentLocation();
      setCustomMarkerIcon();
      getPolyPoints();
    });

    return currentLocation == null
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 16,
                ),
                mapType: currentMapType,
                onMapCreated: ((mapController) {
                  _controller.complete(mapController);
                }),
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                    icon: currentLocationIcon,
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.red,
                    width: 10,
                  ),
                },
              ),

            ],
          );
  }
}

class MapFloatButtons extends StatelessWidget {
  const MapFloatButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 24, right: 12),
      alignment: Alignment.topRight,
      child: Column(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.map,
              size: 30,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            child: const Icon(
              Icons.add_location,
              size: 36,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: Colors.indigoAccent,
            child: const Icon(
              Icons.location_city,
              size: 36,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.home_rounded,
              size: 36,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

extension MapWidgetExtension on MapWidget {
  void changeMapType() {
    currentMapType =
        currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
  }

  void getCurrentLocation() async {
    Location location = Location();

    await location.getLocation().then((value) {
      currentLocation = value;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
          ),
        ),
      );
    });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then((icon) {
      destinationIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(MapWidget.sourceLocation.latitude,
          MapWidget.sourceLocation.longitude),
      PointLatLng(
          MapWidget.destination.latitude, MapWidget.destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
  }
}
