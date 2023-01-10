import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Controller/google_maps_controller.dart';
import 'package:geo_app/Client/Controller/weather_controller.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/googlemaps_two_distance.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_showdialog.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:collection/collection.dart';

///mapIndexed
import 'package:geo_app/components/line_graph.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PlanPage extends HookWidget {
  PlanPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;
  WeatherController weatherController = WeatherController();
  GoogleMapsController googleMapsController = GoogleMapsController();

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);
    plan() async {
      LatLng currentLocation = LatLng(
        mapsProvider.currentLocation!.latitude!,
        mapsProvider.currentLocation!.longitude!,
      );
      LatLng? destinationProvider = provider.isDestinationPinned
          ? currentLocation
          : provider.destination!.toLatLng();
      LatLng? sourceProvider = provider.isDestinationPinned
          ? currentLocation
          : provider.source!.toLatLng();

      GoogleMapsTwoDistanceBasicModel googleMapsTwoDistanceBasicModel =
          await googleMapsController.getDistanceTwoLocation(
        dlat: destinationProvider.latitude,
        dlong: destinationProvider.longitude,
        slat: sourceProvider.latitude,
        slong: sourceProvider.longitude,
      );

      GoogleMapsBasicElevationModel destinationElevation =
          await googleMapsController.getElevation(
        latitute: destinationProvider.latitude,
        longtitude: destinationProvider.longitude,
      );

      GoogleMapsBasicElevationModel sourceElevation =
          await googleMapsController.getElevation(
        latitute: sourceProvider.latitude,
        longtitude: sourceProvider.longitude,
      );

      WeatherBasicModel destinationWeather =
          await weatherController.getWeatherByLatLang(
        lat: destinationProvider.latitude,
        lang: destinationProvider.longitude,
      );

      WeatherBasicModel sourceWeather =
          await weatherController.getWeatherByLatLang(
        lat: sourceProvider.latitude,
        lang: sourceProvider.longitude,
      );

      var data = [
        destinationElevation.elevationList!.first.elevation,
        sourceElevation.elevationList!.first.elevation
      ];
      List<PointLine> dataList = data
          .mapIndexed(
              ((index, element) => PointLine(x: index.toDouble(), y: element!)))
          .toList();

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            "Plan Route",
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            children: [
              //TODO: ikon linki: "https://openweathermap.org/img/w/02n.png"
              Text(
                  "Destination Sıcaklık ${(destinationWeather.mainModel!.temp! - 273).toStringAsFixed(2)}°C"),
              Text(
                  "Source Sıcaklık ${(sourceWeather.mainModel!.temp! - 273).toStringAsFixed(2)}°C"),
              Text(
                  "Aradaki mesafe: ${googleMapsTwoDistanceBasicModel.rowsModel!.first.elements!.first.distance!.text}"),
              Text(
                  "Aradaki süre: ${googleMapsTwoDistanceBasicModel.rowsModel!.first.elements!.first.duration!.text}"),
              Text(
                  "Destination Elevation: ${destinationElevation.elevationList!.first.elevation}"),
              Text(
                  "Source Elevation: ${sourceElevation.elevationList!.first.elevation}"),
              SizedBox(height: 50),
              Container(
                height: 200,
                width: 200,
                child: LineChartWidget(dataList),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Save"),
            ),
          ],
        ),
      );
    }

    bottomSheet(context) async {
      await Future.delayed(const Duration(milliseconds: 100));
      await showModalBottomSheet(
        context: context,
        backgroundColor: Constants.darkBluishGreyColor,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mapsProvider),
            ChangeNotifierProvider.value(value: provider),
          ],
          child: Wrap(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Divider(
                      height: 16,
                      thickness: 2,
                      color: Constants.primaryColor.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 8),
                          child: Icon(
                            Icons.close,
                            size: 28,
                            color: Constants.primaryColor.withOpacity(.6),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
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
              //if (provider.source != null && provider.destination != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: InkWell(
                  onTap: plan,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Constants.primaryColor.withOpacity(.8),
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(Icons.route, color: Colors.white, size: 26),
                        SizedBox(width: 12),
                        Text(
                          "Plan",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
