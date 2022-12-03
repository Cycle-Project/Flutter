import 'package:geo_app/GPS/position_model.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PlanRouteProvider extends MapAction {
  PlanRouteProvider({required super.mapsProvider});

  setPoints(LatLng? latLng) async {
    destination = latLng != null ? PositionModel.fromLatLng(latLng) : null;
    await getPolyPoints();
  }

  @override
  onLocationChanged(LocationData? currentLocation) {}
}
