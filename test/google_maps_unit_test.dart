import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Client/Controller/google_maps_controller.dart';
import 'package:geo_app/Client/Models/GoogleMaps/Elevation/basic_elevation_model.dart';
import 'package:geo_app/Client/Models/GoogleMaps/TwoDistance/googlemaps_two_distance.dart';

void main() {
  group("Google Maps Unit Test", () {
    late GoogleMapsController googleMapsController;

    setUp(() {
      googleMapsController = GoogleMapsController();
    });

    test("Distance matrix", () async {
      GoogleMapsTwoDistanceBasicModel model =
          await googleMapsController.getDistanceTwoLocation(
        dlat: 39.763384170515536,
        dlong: 30.52484817802906,
        slat: 39.146971,
        slong: 34.157752,
      );

      expectLater(model.destinationAddresses!.first,
          "Paşa, Çürükhoca Sk No:5, 26030 Odunpazarı/Eskişehir, Türkiye");
      expectLater(model.originAddresses!.first,
          "Medrese, Prof. Dr. Mehmet Ali Altın Blv. No:59, 40100 Kırşehir Merkez/Kırşehir, Türkiye");
      expectLater(model.rowsModel!.first.elements!.first.duration!.text,
          "4 hours 21 mins");
      expectLater(
          model.rowsModel!.first.elements!.first.distance!.text, "388 km");
    });

    test("Elevation", () async {
      GoogleMapsBasicElevationModel model =
          await googleMapsController.getElevation(
        latitute: 39.146971,
        longtitude: 34.157752,
      );

      expectLater(model.elevationList!.first.elevation, 985.3634643554688);
    });
  });
}
