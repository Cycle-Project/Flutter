import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Controller/route_controller.dart';
import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_elevation.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_speed_time_component.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_weather_container.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/main.dart';

class PlanRouteCustomDialog extends HookWidget {
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  PlanRouteCustomDialog({
    Key? key,
    required this.mapsProvider,
    required this.provider,
  }) : super(key: key);

  final RouteController _routeController = RouteController();

  @override
  build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Plan Route",
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          Text(
              "PolylineCoordinates => ${mapsProvider.polylineCoordinates.length}"),
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
          onPressed: () async {
            if (applicationUserModel == null) return;
            String? userToken = applicationUserModel!.token;
            _routeController.createRoute({
              "positions": mapsProvider.polylineCoordinates
                  .map((e) => Position.fromLatLng(e)),
              "userMadeId": "63b17cb6e0fec3e19def2359"
            }, token: userToken!);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
