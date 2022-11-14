// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final controller = Completer<GoogleMapController>();
    final markers = useState<Set<Marker>>({});
    final shouldRecord = useState(true);
    final visible = useState(true);

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

/*     handleMarkers() {
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
    } */

    useEffect(() {
      Future.microtask(() async {
        googleMapController = await controller.future;
        await zoomToLocation(LatLng(
          mapsProvider.currentLocation!.latitude!,
          mapsProvider.currentLocation!.longitude!,
        ));
      });
      //handleMarkers();
      return () {};
    }, [
      controller,
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
                onCameraIdle: () => visible.value = true,
                onCameraMove: (_) => visible.value = false,
                onTap: (latLng) async {
                  shouldRecord.value = false;
                  markers.value.add(
                    Marker(
                      markerId: const MarkerId("mark"),
                      position: latLng,
                      icon: sourceIcon,
                      infoWindow: const InfoWindow(title: "Marked Location"),
                    ),
                  );
                  await zoomToLocation(latLng);
                  mapsProvider.setPoints(latLng);
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
                    width: 4,
                  ),
                },
              ),
              Visibility(
                visible: visible.value,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: InkWell(
                        onTap: () async {
                          await zoomToLocation(LatLng(
                            mapsProvider.currentLocation!.latitude!,
                            mapsProvider.currentLocation!.longitude!,
                          ));
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[400]!,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.my_location_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visible.value && shouldRecord.value,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SpecialCard(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.transparent,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.circle,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Text(
                              "Record My Route",
                              style: TextStyle(
                                fontSize: 20,
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
              Visibility(
                visible: visible.value && !shouldRecord.value,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SpecialCard(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.transparent,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.route,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Text(
                              "Plan Route",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                              mapsProvider.setPoints(null);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.close_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
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
