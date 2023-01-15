import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/google_maps_view_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/components/line_graph.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ElevationContainer extends HookWidget {
  const ElevationContainer({
    Key? key,
    required this.onTouch,
    required this.gmvm,
  }) : super(key: key);
  final Function(int) onTouch;
  final GMViewModel gmvm;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final list = useState(<double>[]);

    useEffect(() {
      Future.microtask(() async {
        //destinationElevation.value = await vmGoogleMaps.destinationElevation;
        List<double> newList = [];
        for (LatLng e in mapsProvider.polylineCoordinates) {
          var elevationModel = await gmvm.getElevationModel(e);
          double value = double.parse(gmvm.elevation(elevationModel));
          newList.add(value);
        }
        list.value = newList;
      });
      return null;
    }, [mapsProvider.polylineCoordinates]);

    const style1 = TextStyle(fontSize: 12, color: Colors.black54);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Elevation (meters)", style: style1),
          const SizedBox(height: 8),
          list.value.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Calculating...")],
                )
              : SizedBox(
                  height: 100,
                  width: 200,
                  child: LineChartWidget(
                    onTouch: onTouch,
                    points: list.value
                        .asMap()
                        .map((i, e) => MapEntry(i, PointLine(x: i + 0.0, y: e)))
                        .values
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
