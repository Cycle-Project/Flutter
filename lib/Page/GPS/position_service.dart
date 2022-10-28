import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/GPS/location_service.dart';
import 'package:geo_app/Page/GPS/position_model.dart';
import 'package:geo_app/Page/Record/record_button.dart';
import 'package:location/location.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final record = useState(false);
    final position = useState<LocationData?>(null);

    useEffect(() {
      location.onLocationChanged.listen((event) {
        position.value = event;
        PositionModel positionModel = PositionModel(
          latitude: position.value!.latitude,
          longitude: position.value!.longitude,
          altitude: position.value!.altitude,
        );
      });
      return () {};
    }, [record, position]);

    if (position.value == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return Stack(
      children: [
        ColoredBox(
          color: const Color.fromARGB(255, 171, 171, 171),
          child: Center(
            child: Text(
              'latitude: ${position.value!.latitude} \n'
              'longitude: ${position.value!.longitude} \n'
              'altitude: ${position.value!.altitude} \n'
              'speed: ${position.value!.speed} \n'
              'heading: ${position.value!.heading}',
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => record.value = !record.value,
              child: RecordButton(
                isRecording: record.value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
