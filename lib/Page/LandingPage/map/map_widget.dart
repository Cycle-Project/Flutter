// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/map_provider.dart';
import 'package:geo_app/components/special_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends HookWidget {
  MapWidget({Key? key}) : super(key: key) {
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

  //static const LatLng sourceLocation = LatLng(39.753226, 30.493691);
  //static const LatLng destination = LatLng(39.751031, 30.474830);
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor currentLocationIcon;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final controller = Completer<GoogleMapController>();
    final markers = useState<Set<Marker>>({});
    final shouldRecord = useState(true);

    zoomToLocation(LatLng? target) async {
      GoogleMapController googleMapController = await controller.future;
      if (target != null) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: target,
              zoom: 16,
            ),
          ),
        );
      }
    }

    handleMarkers() {
      if (mapsProvider.sourceLocation != null) {
        markers.value.add(Marker(
          markerId: const MarkerId("sourceLocation"),
          position: LatLng(
            mapsProvider.sourceLocation!.latitude!,
            mapsProvider.sourceLocation!.longitude!,
          ),
          icon: sourceIcon,
          infoWindow: const InfoWindow(title: "Source"),
        ));
      }
      if (mapsProvider.destination != null) {
        markers.value.add(Marker(
          markerId: const MarkerId("destination"),
          position: LatLng(
            mapsProvider.destination!.latitude!,
            mapsProvider.destination!.longitude!,
          ),
          icon: destinationIcon,
          infoWindow: const InfoWindow(title: "Destination"),
        ));
      }
    }

    useEffect(() {
      zoomToLocation(LatLng(
        mapsProvider.currentLocation!.latitude!,
        mapsProvider.currentLocation!.longitude!,
      ));


      mapsProvider.destination = PositionModel(latitude: 39.753341, longitude: 30.494186);
      mapsProvider.sourceLocation = PositionModel(latitude: 39.752092, longitude: 30.592252);
      handleMarkers();
      Future.microtask(() async => await mapsProvider.getPolyPoints());
      return () {};
    }, [
      mapsProvider.currentLocation,
      mapsProvider.sourceLocation,
      mapsProvider.destination,
      markers.value,
    ]);

    return mapsProvider.currentLocation == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    mapsProvider.currentLocation!.latitude!,
                    mapsProvider.currentLocation!.longitude!,
                  ),
                  zoom: 16,
                ),
                onMapCreated: (map) => controller.complete(map),

                onTap: (latLng) {
                  shouldRecord.value = false;
                  markers.value.add(
                    Marker(
                      markerId: const MarkerId("mark"),
                      position: latLng,
                      icon: destinationIcon,
                      infoWindow: const InfoWindow(title: "Marked Location"),
                    ),
                  );
                  zoomToLocation(latLng);
                },
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
                    width: 10,
                  ),
                },
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: shouldRecord.value ? 1 : 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SpecialCard(
                    shadowColor: Colors.black.withOpacity(.4),
                    size: const Size(double.maxFinite, 80),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Record My Route",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Icon(
                                Icons.circle,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: shouldRecord.value ? 0 : 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SpecialCard(
                    shadowColor: Colors.black.withOpacity(.4),
                    size: const Size(double.maxFinite, 80),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Plan Route",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              markers.value.removeWhere(
                                (element) =>
                                    element.markerId == const MarkerId("mark"),
                              );
                              shouldRecord.value = true;
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.route,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
