import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/google_maps_controller.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/googlemaps_two_distance.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/components/line_graph.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlanRouteViewModelGoogleMaps {
  late GoogleMapsController googleMapsController;
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;
  final BuildContext context;

  PlanRouteViewModelGoogleMaps({
    required this.context,
    required this.mapsProvider,
    required this.provider,
  }) {
    googleMapsController = GoogleMapsController();
  }

  get currentLocation {
    return LatLng(
      mapsProvider.currentLocation!.latitude!,
      mapsProvider.currentLocation!.longitude!,
    );
  }

  get destinationProvider {
    return provider.isDestinationPinned
        ? currentLocation
        : provider.destination!.toLatLng();
  }

  get sourceProvider {
    return provider.isDestinationPinned
        ? currentLocation
        : provider.source!.toLatLng();
  }

  ///---------------------------------------------------------------------------

  Future<GoogleMapsTwoDistanceBasicModel>
      get googleMapsTwoDistanceBasicModel async {
    return await googleMapsController.getDistanceTwoLocation(
      dlat: destinationProvider.latitude,
      dlong: destinationProvider.longitude,
      slat: sourceProvider.latitude,
      slong: sourceProvider.longitude,
    );
  }

  Future<String> get twoDistanceKilometres async {
    GoogleMapsTwoDistanceBasicModel model =
        await googleMapsTwoDistanceBasicModel;
    return "${model.rowsModel!.first.elements!.first.distance!.text}";
  }

  Future<String> get twoDistanceDuration async {
    GoogleMapsTwoDistanceBasicModel model =
        await googleMapsTwoDistanceBasicModel;
    return "${model.rowsModel!.first.elements!.first.duration!.text}";
  }

  Future<String> get twoDistanceEstimateSpeed async {
    String km = await twoDistanceKilometres;
    //Todo: 100 m altında olursa 0. küsür cinsinden vermiyor 60m diyor mesela
    km = km.replaceAll(RegExp(r'[a-zA-Z]'), "");

    String min = await twoDistanceDuration;
    min = min.replaceAll(RegExp(r'[a-zA-Z]'), "");
    //Todo: @yahya saatleri de dakikaya çevirmek lazım
    double speed = double.parse(km) / (double.parse(min) / 60);
    return "${speed.toStringAsFixed(1)} km/h";
  }

  Future<GoogleMapsBasicElevationModel> get destinationElevationModel async {
    return await googleMapsController.getElevation(
      latitute: destinationProvider.latitude,
      longtitude: destinationProvider.longitude,
    );
  }

  Future<GoogleMapsBasicElevationModel> get sourceElevationModel async {
    return await googleMapsController.getElevation(
      latitute: sourceProvider.latitude,
      longtitude: sourceProvider.longitude,
    );
  }

  Future<String> get destinationElevation async {
    GoogleMapsBasicElevationModel model = await destinationElevationModel;
    return model.elevationList!.first.elevation!.toStringAsFixed(2);
  }

  Future<String> get sourceElevation async {
    GoogleMapsBasicElevationModel model = await sourceElevationModel;
    return model.elevationList!.first.elevation!.toStringAsFixed(2);
  }

  //TODO: Set edilebilir olması lazım. Birden fazla mark olması durumunda
  get lineChartData async {
    GoogleMapsBasicElevationModel destinationModel = await destinationElevationModel;
    GoogleMapsBasicElevationModel elevationModel = await destinationElevationModel;

    double firstValue = destinationModel.elevationList!.first.elevation! -
        elevationModel.elevationList!.first.elevation!;
    double secondValue = elevationModel.elevationList!.first.elevation! -
        destinationModel.elevationList!.first.elevation!;
    return [
      firstValue.abs(),
      secondValue.abs(),
    ];
  }

  Future get pointLineData async {
    return lineChartData
        .mapIndexed(
            ((index, element) => PointLine(x: index.toDouble(), y: element!)))
        .toList();
  }
}
