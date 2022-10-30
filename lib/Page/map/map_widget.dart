import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/map/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends HookWidget {
  MapWidget({
    super.key,
  });

  final Completer<GoogleMapController> _controller = Completer();

  //static const LatLng sourceLocation = LatLng(39.753226, 30.493691);
  //static const LatLng destination = LatLng(39.751031, 30.474830);

  @override
  Widget build(BuildContext context) {
    MapsProvider mapsProvider =
        Provider.of<MapsProvider>(context, listen: false);

    final currentMapType = useState(MapType.normal);

    getCurrentLocation() async {
      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              mapsProvider.currentLocation!.latitude!,
              mapsProvider.currentLocation!.longitude!,
            ),
            zoom: 16,
          ),
        ),
      );
    }

    final sourceIcon = useState(BitmapDescriptor.defaultMarker);
    final destinationIcon = useState(BitmapDescriptor.defaultMarker);
    final currentLocationIcon = useState(BitmapDescriptor.defaultMarker);

    setCustomMarkerIcon() async {
      sourceIcon.value = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_source.png");
      destinationIcon.value = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_destination.png");
      currentLocationIcon.value = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Badge.png");
    }

    useEffect(() {
      getCurrentLocation();
      setCustomMarkerIcon();
      return () {};
    }, []);

    if (mapsProvider.currentLocation == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              mapsProvider.currentLocation!.latitude!,
              mapsProvider.currentLocation!.longitude!,
            ),
            zoom: 16,
          ),
          mapType: currentMapType.value,
          onMapCreated: (mapController) => _controller.complete(mapController),
          markers: {
            Marker(
              markerId: const MarkerId("currentLocation"),
              position: LatLng(
                mapsProvider.currentLocation!.latitude!,
                mapsProvider.currentLocation!.longitude!,
              ),
              icon: currentLocationIcon.value,
            ),
            if (mapsProvider.sourceLocation != null)
              Marker(
                markerId: const MarkerId("sourceLocation"),
                position: LatLng(
                  mapsProvider.sourceLocation!.latitude!,
                  mapsProvider.sourceLocation!.longitude!,
                ),
                icon: sourceIcon.value,
              ),
            if (mapsProvider.destination != null)
              Marker(
                markerId: const MarkerId("destination"),
                position: LatLng(
                  mapsProvider.destination!.latitude!,
                  mapsProvider.destination!.longitude!,
                ),
                icon: destinationIcon.value,
              ),
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: mapsProvider.polylineCoordinates,
              color: Colors.red,
              width: 10,
            ),
          },
        ),
      ],
    );
  }
}
