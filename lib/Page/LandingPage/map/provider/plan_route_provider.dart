import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:location/location.dart';

class PlanRouteProvider extends MapAction {
  PlanRouteProvider({
    required super.mapsProvider,
  });

  setSource({bool isPinned = false, Position? newSorce}) async {
    if (!isPinned) {
      isSourcePinned = false;
      source = newSorce;
      if (source == null) mapsProvider.polylineCoordinates = [];
    } else {
      isSourcePinned = true;
      source = Position.fromLocationData(mapsProvider.currentLocation!);
    }
    mapsProvider.mapAction = this;

    notifyListeners();
    await getPolyPoints();
  }

  setDestination({bool isPinned = false, Position? newDestination}) async {
    if (!isPinned) {
      isDestinationPinned = false;
      destination = newDestination;
      if (destination == null) mapsProvider.polylineCoordinates = [];
    } else {
      isDestinationPinned = true;
      destination = Position.fromLocationData(mapsProvider.currentLocation!);
    }
    mapsProvider.mapAction = this;

    notifyListeners();
    await getPolyPoints();
  }

  @override
  onLocationChanged(LocationData? currentLocation) async {
    if (isSourcePinned) {
      source = Position.fromLocationData(mapsProvider.currentLocation!);
    }
    if (isDestinationPinned) {
      destination = Position.fromLocationData(mapsProvider.currentLocation!);
    }
    await getPolyPoints();
  }
}
