import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/google_maps_view_model.dart';

class SpeedTimeContainer extends HookWidget {
  const SpeedTimeContainer({
    Key? key,
    required this.gmvm,
  }) : super(key: key);
  final GMViewModel gmvm;

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 12, color: Colors.black45);
    const style2 = TextStyle(fontSize: 16, color: Colors.black);

    final twoDistanceKilometres = useState("");
    final twoDistanceDuration = useState("");
    final twoDistanceEstimateSpeed = useState("");

    useEffect(() {
      Future.microtask(() async {
        twoDistanceKilometres.value = await gmvm.twoDistanceKilometres;
        twoDistanceDuration.value = await gmvm.twoDistanceDuration;
        twoDistanceEstimateSpeed.value = await gmvm.twoDistanceEstimateSpeed;
      });
      return null;
    }, []);

    return Row(
      children: [
        Column(
          children: [
            const Text("Speed", style: style1),
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
            const Text("Distance", style: style1),
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
