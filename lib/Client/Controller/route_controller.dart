// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/route_interface.dart';
import 'package:geo_app/Client/Models/Route/route.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';

class RouteController with IRoute {
  late Client _client;
  late Map _requestMap;

  RouteController() {
    _client = Client();
    _requestMap = ClientConstants.paths["route"];
  }

  ///MARK: GET USERS LIST
  @override
  Future<List<Route>> getRoutes({required token}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["list"],
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      List? list = response.data['data'];
      if (list == null) {
        throw Exception("An Error Occured!");
      }
      List<Route>? routes = list.map((e) => Route.fromJson(e)).toList();
      return routes;
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return [];
  }

  ///MARK: GET ROUTES OF USER
  @override
  Future<List<Route>> getRoutesOf({required id, required token}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["routes-of"] + "/$id",
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      List? list = response.data['data'];
      if (list == null) {
        throw Exception("An Error Occured!");
      }
      List<Route>? routes = list.map((e) => Route.fromJson(e)).toList();
      return routes;
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return [];
  }

  @override
  Future<Route> createRoute(
    Map map, {
    required String token,
  }) async {
    try {
      final response = await _client.postMethod(
        _requestMap["create-route"],
        value: map,
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return Route.fromJson(response.data['data']);
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return Route();
  }

  @override
  Future<Route> addPosition(
    Map map, {
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.putMethod(
        "${_requestMap["add-position"]}/$id",
        value: map,
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return Route.fromJson(response.data['data']);
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return Route();
  }

  @override
  Future<Route> update(
    Map map, {
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.putMethod(
        "${_requestMap["update"]}/$id",
        value: map,
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return Route.fromJson(response.data);
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return Route();
  }

  @override
  Future<bool> deleteById({
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.deleteMethod(
        "${_requestMap["deletebyid"]}/$id",
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return true;
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return false;
  }
}
