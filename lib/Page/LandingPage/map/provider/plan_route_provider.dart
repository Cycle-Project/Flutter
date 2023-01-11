import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:location/location.dart';

class PlanRouteProvider extends MapAction {
  PlanRouteProvider({
    required super.mapsProvider,
  });

  setSource({bool isPinned = false, PositionModel? newSorce}) async {
    if (!isPinned) {
      isSourcePinned = false;
      source = newSorce;
    } else {
      isSourcePinned = true;
      source = PositionModel.fromLocationData(mapsProvider.currentLocation!);
    }
    mapsProvider.mapAction = this;

    notifyListeners();
    await getPolyPoints();
  }

  setDestination({bool isPinned = false, PositionModel? newDestination}) async {
    if (!isPinned) {
      isDestinationPinned = false;
      destination = newDestination;
    } else {
      isDestinationPinned = true;
      destination =
          PositionModel.fromLocationData(mapsProvider.currentLocation!);
    }
    mapsProvider.mapAction = this;

    notifyListeners();
    await getPolyPoints();
  }

  @override
  onLocationChanged(LocationData? currentLocation) async {
    if (isSourcePinned) {
      source = PositionModel.fromLocationData(mapsProvider.currentLocation!);
    }
    if (isDestinationPinned) {
      destination =
          PositionModel.fromLocationData(mapsProvider.currentLocation!);
    }
    await getPolyPoints();
  }
}
