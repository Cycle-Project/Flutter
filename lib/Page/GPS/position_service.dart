import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/GPS/location_service.dart';
import 'package:geo_app/Page/GPS/position_model.dart';
import 'package:geo_app/Page/Record/record_button.dart';
import 'package:geo_app/Page/map/map_provider.dart';
import 'package:geo_app/Page/map/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final record = useState(false);
    final currentLocation = useState<LocationData?>(null);
    final sourceLocation = useState<LocationData?>(null);
    final destination = useState<LocationData?>(null);
    final polylineCoordinates = useState(<LatLng>[]);


    useEffect(() {
      location.onLocationChanged.listen((event) {
        currentLocation.value = event;
        PositionModel positionModel = PositionModel(
          latitude: currentLocation.value!.latitude,
          longitude: currentLocation.value!.longitude,
          altitude: currentLocation.value!.altitude,
        );
      });
      return () {};
    }, [record, currentLocation]);

    if (currentLocation.value == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return ChangeNotifierProvider<MapsProvider>(
      create: (context) => MapsProvider(
        currentLocation: currentLocation,
        sourceLocation: sourceLocation,
        destination: destination,
        polylineCoordinates: polylineCoordinates,

      ),
      child: Stack(
        children: [
          ColoredBox(
            color: const Color.fromARGB(255, 171, 171, 171),
            child: MapWidget(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Builder(
                builder: (context) {
                  MapsProvider mapsProvider = Provider.of<MapsProvider>(context, listen: false);
                  return GestureDetector(
                    onTap: () async {
                      record.value = !record.value;
                      if (record.value && currentLocation.value != null) {
                        LocationData locat = LocationData.fromMap({
                          'latitude': 39.753226,
                          'longitude': 30.493691
                        });
                        mapsProvider.sourceLocation.value = locat;
                        mapsProvider.destination.value = currentLocation.value;

                      } else {
                        mapsProvider.sourceLocation.value = null;
                        mapsProvider.destination.value = null;
                      }
                      await mapsProvider.getPolyPoints();
                    },
                    child: RecordButton(
                      isRecording: record.value,
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Text(
              'latitude: ${position.value!.latitude} \n'
              'longitude: ${position.value!.longitude} \n'
              'altitude: ${position.value!.altitude} \n'
              'speed: ${position.value!.speed} \n'
              'heading: ${position.value!.heading}',
              style: const TextStyle(fontSize: 32),
            ),

*/
