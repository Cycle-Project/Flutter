// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends HookWidget {
  MapWidget({
    Key? key,
    required this.shouldClearMark,
    required this.shouldAddMark,
    this.gesturesEnabled = true,
  }) : super(key: key) {
    Future.microtask(() async {
      const size = Size(120, 120);
      const config = ImageConfiguration(size: size);
      try {
        sourceIcon = await BitmapDescriptor.fromAssetImage(
            config, "assets/icon/Pin_source.png");
        destinationIcon = await BitmapDescriptor.fromAssetImage(
            config, "assets/icon/Pin_destination.png");
        currentLocationIcon = await BitmapDescriptor.fromAssetImage(
            config, "assets/icon/Badge.png");
      } catch (e) {
        print(e);
      }
    });
  }
  final bool Function(LatLng) shouldAddMark;
  final bool shouldClearMark;
  final bool gesturesEnabled;

  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor currentLocationIcon;
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final controller = Completer<GoogleMapController>();
    final markers = useState<Set<Marker>>({});
    const markId = MarkerId("mark");

    getCurrentLocation() => LatLng(
          mapsProvider.currentLocation!.latitude!,
          mapsProvider.currentLocation!.longitude!,
        );

    getRouteLocation() {
      double latitude = 0;
      double longitude = 0;
      int n = mapsProvider.polylineCoordinates.length;

      for (LatLng point in mapsProvider.polylineCoordinates) {
        latitude += point.latitude;
        longitude += point.longitude;
      }

      return LatLng(latitude / n, longitude / n);
    }

    if (shouldClearMark) {
      markers.value.removeWhere((e) => e.markerId == markId);
    }

    Future<void> zoomToLocation(LatLng? target) async {
      if (mapsProvider.polylineCoordinates.isNotEmpty &&
          mapsProvider.mapAction != null) {
        googleMapController.moveCamera(CameraUpdate.newLatLngBounds(
          MapUtils.boundsFromLatLngList(mapsProvider.polylineCoordinates),
          4.0,
        ));
      }
      if (target != null) {
        var zoom = mapsProvider.polylineCoordinates.isEmpty
            ? 16
            : await googleMapController.getZoomLevel();
        await googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: target,
            zoom: zoom - .5,
          )),
        );
      }
    }

    useEffect(() {
      Future.microtask(() async {
        googleMapController = await controller.future;

        LatLng? target = mapsProvider.polylineCoordinates.isNotEmpty &&
                mapsProvider.mapAction != null
            ? getRouteLocation()
            : getCurrentLocation();
        await zoomToLocation(target);
      });
      return null;
    }, [mapsProvider]);

    onTapMap(latLng) async {
      bool shouldMark = shouldAddMark(latLng);
      if (shouldMark) {
        markers.value.add(
          Marker(
            markerId: markId,
            position: latLng,
            icon: sourceIcon,
            infoWindow: const InfoWindow(title: "Marked Location"),
          ),
        );
        zoomToLocation(latLng);
      }
    }

    if (mapsProvider.currentLocation == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: getCurrentLocation(),
        zoom: 16,
      ),
      onMapCreated: (map) => controller.complete(map),
      onTap: (latLng) => onTapMap(latLng),
      zoomGesturesEnabled: gesturesEnabled,
      tiltGesturesEnabled: gesturesEnabled,
      scrollGesturesEnabled: gesturesEnabled,
      rotateGesturesEnabled: gesturesEnabled,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers.value,
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: mapsProvider.polylineCoordinates,
          color: Colors.deepPurpleAccent,
          width: 4,
        ),
      },
    );
  }
}

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}
