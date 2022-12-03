// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/plan_route.dart';
import 'package:geo_app/Page/LandingPage/map/components/record_route.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
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

    useEffect(() {
      Future.microtask(() async {
        googleMapController = await controller.future;
        await zoomToLocation(LatLng(
          mapsProvider.currentLocation!.latitude!,
          mapsProvider.currentLocation!.longitude!,
        ));
      });
      return () {};
    }, [
      controller,
      mapsProvider.currentLocation,
      mapsProvider.mapAction,
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
                  if (mapsProvider.mapAction != null) return;

                  /// TODO : map act tamamla 😘
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
                  (mapsProvider.mapAction as PlanRouteProvider)
                      .setPoints(latLng);
                },
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: {
                  ...markers.value,
                  if (mapsProvider.record)
                    Marker(
                      markerId: const MarkerId("source"),
                      position: mapsProvider.sourceLocation!.latLng,
                      icon: sourceIcon,
                      infoWindow: const InfoWindow(title: "Source Location"),
                    ),
                },
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
                    child: _MyPosition(
                      onTap: () async {
                        await zoomToLocation(LatLng(
                          mapsProvider.currentLocation!.latitude!,
                          mapsProvider.currentLocation!.longitude!,
                        ));
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visible.value && shouldRecord.value,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: RecordRoute(),
                ),
              ),
              Visibility(
                visible: visible.value && !shouldRecord.value,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PlanRoute(
                    onRemove: () {
                      markers.value.removeWhere(
                        (element) => element.markerId == const MarkerId("mark"),
                      );
                      shouldRecord.value = true;
                      mapsProvider.setPoints(null);
                    },
                  ),
                ),
              ),
            ],
          );
  }
}

class _MyPosition extends StatelessWidget {
  const _MyPosition({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: InkWell(
        onTap: onTap,
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
    );
  }
}
