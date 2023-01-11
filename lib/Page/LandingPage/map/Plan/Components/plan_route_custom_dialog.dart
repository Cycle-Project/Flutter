import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_elevation.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_speed_time_component.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_googlemaps.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_weather_container.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/components/line_graph.dart';

class PlanRouteCustomDialog extends HookWidget {
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  const PlanRouteCustomDialog({
    Key? key,
    required this.mapsProvider,
    required this.provider,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Plan Route",
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          SpeedTimeContainer(
            mapsProvider: mapsProvider,
            provider: provider,
          ),
          WeatherContainer(
            mapsProvider: mapsProvider,
            provider: provider,
          ),
          ElevationContainer(
            mapsProvider: mapsProvider,
            provider: provider,
          ),
          /*Text(
              "Destination Elevation: ${destinationElevation.elevationList!.first.elevation}"),
          Text(
              "Source Elevation: ${sourceElevation.elevationList!.first.elevation}"),
          SizedBox(height: 50),
          Container(
            height: 200,
            width: 200,
            child: LineChartWidget(dataList),
          ),*/
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Save"),
        ),
      ],
    );
  }
}
