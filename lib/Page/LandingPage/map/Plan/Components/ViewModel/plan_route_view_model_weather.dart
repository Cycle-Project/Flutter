import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/weather_controller.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PlanRouteViewModelWeather {
  late WeatherController weatherController;
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;
  final BuildContext context;

  PlanRouteViewModelWeather({
    required this.context,
    required this.mapsProvider,
    required this.provider,
  }) {
    weatherController = WeatherController();
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

  Future<WeatherBasicModel> get destinationWeatherModel async {
    return await weatherController.getWeatherByLatLang(
      lat: destinationProvider.latitude,
      lang: destinationProvider.longitude,
    );
  }

  Future<WeatherBasicModel> get sourceWeather async {
    return await weatherController.getWeatherByLatLang(
      lat: sourceProvider.latitude,
      lang: sourceProvider.longitude,
    );
  }

  ///---------------------------------------------------------------------------

  Future<String> get sourceName async {
    WeatherBasicModel model = await destinationWeatherModel;
    return model.name!;
  }

  Future<String> get destinationTemp async {
    WeatherBasicModel model = await destinationWeatherModel;
    return (model.mainModel!.temp! - 273).toStringAsFixed(2);
  }

  Future<String> get sourceTemp async {
    WeatherBasicModel model = await sourceWeather;
    return (model.mainModel!.temp! - 273).toStringAsFixed(2);
  }

  Future<String> get sourceIcon async {
    WeatherBasicModel model = await sourceWeather;
    return model.weatherModel!.first.icon!;
  }

  Future<String> get sourceMain async {
    WeatherBasicModel model = await sourceWeather;
    return model.weatherModel!.first.main!;
  }

  Future<String> get sourceWindSpeed async {
    WeatherBasicModel model = await sourceWeather;
    return "${model.windModel!.speed!} km/h";
  }

  Future<String> get sourceHum async {
    WeatherBasicModel model = await sourceWeather;
    return "${model.mainModel!.humidity!} %";
  }

  String get dateToday {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, d MMMM').format(now);
  }
}
