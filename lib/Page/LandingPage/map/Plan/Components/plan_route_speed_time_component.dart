import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_googlemaps.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';

class SpeedTimeContainer extends HookWidget {
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  const SpeedTimeContainer({
    Key? key,
    required this.mapsProvider,
    required this.provider,
  }) : super(key: key);

  final TextStyle _style = const TextStyle(fontSize: 12, color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    PlanRouteViewModelGoogleMaps vmGoogleMaps = PlanRouteViewModelGoogleMaps(
      context: context,
      provider: provider,
      mapsProvider: mapsProvider,
    );

    final twoDistanceKilometres = useState("");
    final twoDistanceDuration = useState("");
    final twoDistanceEstimateSpeed = useState("");

    useEffect(() {
      Future.microtask(() async {
        twoDistanceKilometres.value = await vmGoogleMaps.twoDistanceKilometres;
        twoDistanceDuration.value = await vmGoogleMaps.twoDistanceDuration;
        twoDistanceEstimateSpeed.value = await vmGoogleMaps.twoDistanceEstimateSpeed;
      });
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                twoDistanceEstimateSpeed.value,
              ),
              Text(
                "Estimated Speed",
                style: _style,
              ),
            ],
          ),
          Column(
            children: [
              Text(twoDistanceDuration.value),
              Text(
                "Time",
                style: _style,
              )
            ],
          ),
          const VerticalDivider(
            thickness: 2,
            color: Colors.red,
          ),
          Column(
            children: [
              Text(twoDistanceKilometres.value),
              Text(
                "Height",
                style: _style,
              )
            ],
          ),
        ],
      ),
    );
  }
}
