import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:location/location.dart';

class RecordRouteProvider extends MapAction {
  bool record;

  RecordRouteProvider({
    this.record = false,
    required super.mapsProvider,
  });

  changeRecordingStatus({bool? isRecording}) {
    record = isRecording ?? !record;
    if (!record || mapsProvider.currentLocation == null) {
      sourceLocation = null;
      destination = null;
      mapsProvider.polylineCoordinates = [];
    } else {
      sourceLocation = destination = PositionModel.fromLocationData(
        mapsProvider.currentLocation!,
      );
    }
    notifyListeners();
  }

  @override
  onLocationChanged(LocationData? currentLocation) async {
    if (record) {
      destination = PositionModel.fromLocationData(currentLocation!);
      // TODO : send destination to service
      await getPolyPoints(isCurrent: false);
    }
  }
}
