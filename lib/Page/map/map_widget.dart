import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geo_app/Page/map/map_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapWidget extends HookWidget {

  MapWidget({
    super.key,
  });

  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  //static const LatLng sourceLocation = LatLng(39.753226, 30.493691);
  //static const LatLng destination = LatLng(39.751031, 30.474830);

  @override
  Widget build(BuildContext context) {

    MapsProvider mapsProvider = Provider.of<MapsProvider>(context, listen: false);

    LocationData? currentLocation = mapsProvider
        .currentLocation.value;

    LocationData? sourceLocation = mapsProvider.sourceLocation.value;
    LocationData? destination = mapsProvider.destination.value;

    List<LatLng> polylineCoordinates = mapsProvider.polylineCoordinates.value;

    final currentMapType = useState(MapType.normal);

    void getCurrentLocation() async {
      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation!.latitude!,
              currentLocation.longitude!,
            ),
            zoom: 16,
          ),
        ),
      );
    }

    void setCustomMarkerIcon() async {
      sourceIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_source.png");
      destinationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_destination.png");
      currentLocationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Badge.png");
    }



    useEffect(() {
      getCurrentLocation();
      setCustomMarkerIcon();
      return () {};
    }, []);

    if (currentLocation == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            ),
            zoom: 16,
          ),
          mapType: currentMapType.value,
          onMapCreated: ((mapController) {
            _controller.complete(mapController);
          }),
          markers: {
            Marker(
              markerId: const MarkerId("currentLocation"),
              position: LatLng(
                currentLocation.latitude!,
                currentLocation.longitude!,
              ),
              icon: currentLocationIcon,
            ),
            if (sourceLocation != null) Marker(
              markerId: const MarkerId("sourceLocation"),
              position: LatLng(
                sourceLocation.latitude!,
                sourceLocation.longitude!,
              ),
              icon: sourceIcon,
            ),
            if (destination != null) Marker(
              markerId: const MarkerId("destination"),
              position: LatLng(
                destination.latitude!,
                destination.longitude!,
              ),
              icon: destinationIcon,
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
        Text(Provider.of<MapsProvider>(context, listen: false)
            .currentLocation.value!.longitude!.toString()),
      ],
    );
  }
}

/*class MapFloatButtons extends StatelessWidget {
  const MapFloatButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    currentMapType.value = currentMapType.value == MapType.normal
        ? MapType.satellite
        : MapType.normal;
  }

  
} */
