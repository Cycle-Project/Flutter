// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends HookWidget {
  MapWidget({
    Key? key,
    required this.shouldClearMark,
    required this.shouldAddMark,
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

    Future<void> zoomToLocation(LatLng? target) async {
      if (target != null) {
        await googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: target,
              zoom: 16,
            ),
          ),
        );
      }
    }

    if (shouldClearMark) {
      markers.value.removeWhere((e) => e.markerId == markId);
    }

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

    getCurrentLocation() => LatLng(
          mapsProvider.currentLocation!.latitude!,
          mapsProvider.currentLocation!.longitude!,
        );

    getRouteLocation() => PositionModel.middlePoint(
            mapsProvider.mapAction!.source!,
            mapsProvider.mapAction!.destination!)
        .toLatLng();

    useEffect(() {
      Future.microtask(() async {
        googleMapController = await controller.future;
        await zoomToLocation(mapsProvider.mapAction != null
            ? getRouteLocation()
            : getCurrentLocation());
      });
      return null;
    }, [mapsProvider]);

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
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
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
