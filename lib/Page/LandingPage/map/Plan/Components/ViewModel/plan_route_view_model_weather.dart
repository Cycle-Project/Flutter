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

  PlanRouteViewModelWeather({
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

  String sourceName(WeatherBasicModel model) => model.name!;

  String destinationTemp(WeatherBasicModel model) =>
      (model.mainModel!.temp! - 273).toStringAsFixed(2);

  String sourceTemp(WeatherBasicModel model) =>
      (model.mainModel!.temp! - 273).toStringAsFixed(2);

  String sourceIcon(WeatherBasicModel model) => model.weatherModel!.first.icon!;

  String sourceMain(WeatherBasicModel model) => model.weatherModel!.first.main!;

  String sourceWindSpeed(WeatherBasicModel model) =>
      "${model.windModel!.speed!} km/h";

  String sourceHum(WeatherBasicModel model) =>
      "${model.mainModel!.humidity!} %";

  String get dateToday {
    DateTime now = DateTime.now();
    return DateFormat('d MMMM (EEEE)').format(now);
  }
}
