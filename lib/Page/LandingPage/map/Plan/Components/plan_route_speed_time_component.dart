import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_googlemaps.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class SpeedTimeContainer extends HookWidget {
  const SpeedTimeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 12, color: Colors.black45);
    const style2 = TextStyle(fontSize: 16, color: Colors.black);
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

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
        twoDistanceEstimateSpeed.value =
            await vmGoogleMaps.twoDistanceEstimateSpeed;
      });
      return null;
    }, []);

    return Row(
      children: [
        Column(
          children: [
            const Text("Estimated Speed", style: style1),
            const SizedBox(height: 8),
            Text(
              twoDistanceEstimateSpeed.value,
              style: style2,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
          ],
        ),
        Column(
          children: [
            const Text("Time", style: style1),
            const SizedBox(height: 8),
            Text(
              twoDistanceDuration.value,
              style: style2,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
          ],
        ),
        Column(
          children: [
            const Text("Height", style: style1),
            const SizedBox(height: 8),
            Text(
              twoDistanceKilometres.value,
              style: style2,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ]
          .map(
            (e) => Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
