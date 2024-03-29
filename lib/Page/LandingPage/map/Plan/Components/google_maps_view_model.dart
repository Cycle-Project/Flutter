import 'package:geo_app/Client/Controller/google_maps_controller.dart';
import 'package:geo_app/Client/Controller/weather_controller.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/googlemaps_two_distance.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class GMViewModel {
  final googleMapsController = GoogleMapsController();
  final _weatherController = WeatherController();

  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  GMViewModel({
    required this.mapsProvider,
    required this.provider,
  });

  LatLng get currentLocation => LatLng(
        mapsProvider.currentLocation!.latitude!,
        mapsProvider.currentLocation!.longitude!,
      );

  LatLng get destinationProvider => provider.isDestinationPinned
      ? currentLocation
      : provider.destination!.toLatLng();

  LatLng get sourceProvider => provider.isDestinationPinned
      ? currentLocation
      : provider.source!.toLatLng();

  String dateToday() => DateFormat('d MMMM (EEEE)').format(DateTime.now());

  ///---------------------------------------------------------------------------

  Future<GMDistanceBetween> get googleMapsTwoDistanceBasicModel async =>
      await googleMapsController.getDistanceTwoLocation(
        dlat: destinationProvider.latitude,
        dlong: destinationProvider.longitude,
        slat: sourceProvider.latitude,
        slong: sourceProvider.longitude,
      );

  Future<String> get twoDistanceKilometres async {
    GMDistanceBetween model = await googleMapsTwoDistanceBasicModel;
    return "${model.rowsModel!.first.elements!.first.distance!.text}";
  }

  Future<String> get twoDistanceDuration async {
    GMDistanceBetween model = await googleMapsTwoDistanceBasicModel;
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

  Future<GMElevations> getElevationModel(LatLng latLng) async {
    return await googleMapsController.getElevation(
      latitute: latLng.latitude,
      longtitude: latLng.longitude,
    );
  }

  String elevation(GMElevations model) =>
      model.elevationList!.first.elevation!.toStringAsFixed(2);

  getWeather(LatLng latLng) => _weatherController.getWeatherByLatLang(
        lat: latLng.latitude,
        lang: latLng.longitude,
      );
}
