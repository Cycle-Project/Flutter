// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/RestUserModel.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';

class UserController with IUser {
  final Client _client = Client();
  final Map _requestMap = ClientConstants.paths["users"];

  ///MARK: GET USERS LIST
  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel>? users;
    try {
      //final response = await dio.get("https://cycleon.onrender.com/api/users/list");
      final response = await _client.getMethod(_requestMap["list"]);
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      users = RestUserModel.fromJson(response.data).data;
      if (users == null) {
        throw Exception("get users data null");
      }
    } catch (e) {
      print("at -> getUsers : $e!");
    }
    return users ?? [];
  }

  ///MARK: POST REGISTER USER
  @override
  Future<UserModel> register(Map map) async {
    UserModel? user;
    try {
      final response = await _client.postMethod(
        path: _requestMap["register"],
        value: map,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      user = UserModel.fromJson(response.data);
    } catch (e) {
      print("at -> register : $e!");
    }
    return user ?? UserModel();
  }

  ///MARK: POST LOGIN USER
  @override
  Future<UserModel> login(Map map) async {
    UserModel? user;
    try {
      final response = await _client.postMethod(
        path: _requestMap["login"],
        value: map,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      //TODO: Bu atama işlemi çalışmıyor
      user = UserModel.fromJson(response.data);

      /// Saving user_id for making requests based on which user is logged in
      if (user.id != null) {
        await CacheManager.saveSharedPref(
          tag: "user_id",
          value: user.id!,
        );
        print("Kaydetti hıı amughnaa");
      } else {
        throw Exception("at -> login : user.id is NULL!");
      }
      /// Registering user_token to make request and pass security system on server
      if (user.token != null) {
        await CacheManager.saveSharedPref(
          tag: "user_token",
          value: user.token!,
        );
      } else {
        throw Exception("at -> login : user.token is NULL!");
      }
    } catch (e) {
      print("at -> login : $e!");
    }
    return user ?? UserModel();
  }

  @override
  Future<UserModel> getById(String id) async {
    UserModel? user;
    try {
      final response = await _client.getMethod(_requestMap["getById"] + "/$id");
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      user = UserModel.fromJson(response.data);
    } catch (e) {
      print("at -> getUsers : $e!");
    }
    return user ?? UserModel();
  }
}
