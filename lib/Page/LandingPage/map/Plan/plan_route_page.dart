import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Controller/route_controller.dart';
import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_elevation.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_speed_time_component.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_weather_container.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/main.dart';

///mapIndexed
import 'package:provider/provider.dart';

class PlanPage extends HookWidget {
  const PlanPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    bottomSheet(context) async {
      await Future.delayed(const Duration(milliseconds: 100));
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mapsProvider),
            ChangeNotifierProvider.value(value: provider),
          ],
          child: const BottomSheet(),
        ),
      );
    }

    useEffect(() {
      bottomSheet(context);
      return null;
    }, []);

    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: [
          SizedBox.expand(
            child: MapWidget(
              shouldClearMark: false,
              shouldAddMark: (_) => false,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.darkBluishGreyColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () async => await bottomSheet(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Constants.darkBluishGreyColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 50,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key}) : super(key: key);
  static final RouteController _routeController = RouteController();

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    save() async {
      String? userToken = applicationUserModel.token;
      await _routeController.createRoute({
        "positions": mapsProvider.polylineCoordinates.map(
          (e) => Position.fromLatLng(e),
        ),
        "userMadeId": applicationUserModel.id,
      }, token: userToken!);
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: .9,
      expand: false,
      builder: (context, scrollController) => AnimatedContainer(
        color: Constants.darkBluishGreyColor,
        duration: const Duration(milliseconds: 800),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Wrap(
            children: [
              const Divider(
                height: 8,
                color: Constants.darkBluishGreyColor,
              ),
              if (provider.source != null && provider.destination != null)
                const SpeedTimeContainer()
              else
                const Divider(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Wrap(
                  children: const [
                    LocationButton(
                      index: 1,
                      name: "Source",
                    ),
                    Divider(
                      height: 20,
                      thickness: .6,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    LocationButton(
                      index: 2,
                      name: "Destination",
                    ),
                  ],
                ),
              ),
              if (provider.source != null && provider.destination != null) ...[
                /* Text(
                  "PolylineCoordinates => ${mapsProvider.polylineCoordinates.length}",
                  style: const TextStyle(color: Colors.white),
                ), */
                const WeatherContainer(),
                const ElevationContainer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: InkWell(
                    onTap: () => save(),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Constants.primaryColor.withOpacity(.8),
                      ),
                      child: Row(
                        children: const [
                          Spacer(),
                          Icon(
                            Icons.save_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Save Route",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else
                const Divider(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
