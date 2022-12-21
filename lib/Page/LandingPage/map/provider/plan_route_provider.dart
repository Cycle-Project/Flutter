import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PlanRouteProvider extends MapAction {
  PlanRouteProvider({
    required super.mapsProvider,
    this.isDestination = true,
    this.state = MyState.PinStart,
  });

  bool isDestination;
  MyState state;

  setPoints(LatLng? latLng) async {
    switch(state) {
      case MyState.None:
        if (isDestination) {
          destination = latLng != null ? PositionModel.fromLatLng(latLng) : null;
        } else {
          sourceLocation = latLng != null ? PositionModel.fromLatLng(latLng) : null;
        }
        break;
      case MyState.PinStart:
        sourceLocation = PositionModel.fromLocationData(mapsProvider.currentLocation!);
        destination = latLng != null ? PositionModel.fromLatLng(latLng) : null;
        break;
      case MyState.PinEnd:
        destination = PositionModel.fromLocationData(mapsProvider.currentLocation!);
        sourceLocation = latLng != null ? PositionModel.fromLatLng(latLng) : null;
        break;
    }
    await getPolyPoints();
  }

  @override
  onLocationChanged(LocationData? currentLocation) {
    if(state == MyState.PinStart) {
      sourceLocation = PositionModel.fromLocationData(mapsProvider.currentLocation!);
    } else if(state == MyState.PinEnd) {
      destination = PositionModel.fromLocationData(mapsProvider.currentLocation!);
    }
  }
}

enum MyState { PinStart, PinEnd, None }
