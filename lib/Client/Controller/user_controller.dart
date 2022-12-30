// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/endpoint.dart';

class UserController with IUser {
  final Client client = Client();
  final Map requestMap = ClientConstants.paths["users"];

  ///MARK: GET USERS LIST
  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel>? response;
    try {
      response = await client.getMethod<List<UserModel>>(
        requestMap["list"],
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
    } catch (e) {
      print("at -> getUsers : $e!");
    }
    return response!;
  }

  ///MARK: POST REGISTER USER
  @override
  Future<UserModel> register(Map map) async {
    UserModel? response;
    try {
      response = await client.postMethod<UserModel>(
        path: requestMap["register"],
        value: map,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
    } catch (e) {
      print("at -> register : $e!");
    }
    return response!;
  }

  ///MARK: POST LOGIN USER
  @override
  Future<UserModel> login(Map map) async {
    UserModel? response;
    try {
      response = await client.postMethod<UserModel>(
        path: requestMap["login"],
        value: map,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }

      /// Saving user_id for making requests based on which user is logged in
      if (response.id != null) {
        CacheManager.saveSharedPref(
          tag: "user_id",
          value: response.id!,
        );
      } else {
        throw Exception("at -> login : user.id is NULL!");
      }

      /// Registering user_token to make request and pass security system on server
      if (response.token != null) {
        CacheManager.saveSharedPref(
          tag: "user_token",
          value: response.token!,
        );
      } else {
        throw Exception("at -> login : user.token is NULL!");
      }
    } catch (e) {
      print("at -> login : $e!");
    }
    return response!;
  }
}
