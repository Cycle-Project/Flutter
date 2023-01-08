import 'package:geo_app/Client/Models/Route/route.dart';

mixin IRoute {
  Future<List<Route>> getRoutes({
    required String token,
  });
  Future<Route> createRoute(
    Map map, {
    required String token,
  });
  Future<Route> addPosition(
    Map map, {
    required String id,
    required String token,
  });
  Future<Route> update(
    Map map, {
    required String id,
    required String token,
  });
  Future<bool> deleteById({
    required String id,
    required String token,
  });
}
