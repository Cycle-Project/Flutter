import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PlanRouteProvider extends MapAction {
  PlanRouteProvider({
    required super.mapsProvider,
  });

  setSource({bool isPinned = false, LatLng? newSorce}) async {
    if (!isSourcePinned && newSorce != null && !isPinned) {
      isSourcePinned = false;
      source = PositionModel.fromLatLng(newSorce);
    } else if (isPinned) {
      isSourcePinned = true;
    } else {
      return;
    }
    mapsProvider.mapAction = this;
    await getPolyPoints();
  }

  setDestination({bool isPinned = false, LatLng? newDestination}) async {
    if (!isDestinationPinned && newDestination != null && !isPinned) {
      isDestinationPinned = false;
      destination = PositionModel.fromLatLng(newDestination);
    } else if (isPinned) {
      isDestinationPinned = true;
    } else {
      return;
    }
    mapsProvider.mapAction = this;
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
