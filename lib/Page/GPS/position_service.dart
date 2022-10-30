import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/GPS/location_service.dart';
import 'package:geo_app/Page/Record/record_button.dart';
import 'package:geo_app/Page/map/map_widget.dart';
import 'package:location/location.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocation = useState<LocationData?>(null);

    useEffect(() {
      location.onLocationChanged.listen((event) {
        currentLocation.value = event;
      });
      return (){};
    });
    if (currentLocation.value == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return Stack(
      children: [
        ColoredBox(
          color: const Color.fromARGB(255, 171, 171, 171),
          child: MapWidget(),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: RecordButton(),
          ),
        ),
      ],
    );
  }
}
