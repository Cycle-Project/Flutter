import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_googlemaps.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';

class ElevationContainer extends HookWidget {
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  const ElevationContainer({
    Key? key,
    required this.mapsProvider,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PlanRouteViewModelGoogleMaps vmGoogleMaps = PlanRouteViewModelGoogleMaps(
      context: context,
      provider: provider,
      mapsProvider: mapsProvider,
    );

    final destinationElevation = useState("");
    final sourceElevation = useState("");

    useEffect(() {
      Future.microtask(() async {
        destinationElevation.value = await vmGoogleMaps.destinationElevation;
        sourceElevation.value = await vmGoogleMaps.sourceElevation;
      });
      return null;
    }, []);

    /* double firstValue = destinationModel.value.elevationList!.first.elevation! -
        elevationModel.value.elevationList!.first.elevation!;
    double secondValue = elevationModel.value.elevationList!.first.elevation! -
        destinationModel.value.elevationList!.first.elevation!;

    List<double> list = [
      firstValue.abs(),
      secondValue.abs(),
    ];

    listPointLine.value = list
        .asMap()
        .map((index, element) =>
        MapEntry(index, PointLine(x: index.toDouble(), y: element)))
        .values
        .toList();*/

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Destination elevation: ${destinationElevation.value}"),
          Text("Source elevation: ${sourceElevation.value}"),
        ],
      ),
    );
  }
}
