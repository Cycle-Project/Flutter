// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/ui_result.dart';
import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Models/User/rest_user_model.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';
import 'package:geo_app/main.dart';

class UserController with IUser {
  late Client _client;
  late Map requestMap;

  UserController() {
    _client = Client();
    requestMap = ClientConstants.paths["users"];
  }

  dispose() {
    _client.dispose();
    requestMap = {};
  }

  ///MARK: SharedPref User
  @override
  Future<bool> cachedLogin() async {
    try {
      String? userId = applicationUserModel.id;
      String? userToken = applicationUserModel.token;

      Map map = {};

      /// Saving user_id for making requests based on which user is logged in
      if (userId != null && userToken != null) {
        print("id: $userId, token: $userToken");
        UserModel prefUser = await getById(id: userId, token: userToken);
        map = prefUser.toJson();
      } else {
        throw Exception("An Error Occured!");
      }
      if (map.isEmpty) {
        throw Exception("An Error Occured!");
      }

      final response = await _client.postMethod(
        requestMap["login"],
        value: map,
      );
      if (response == null || response.data == null) {
        throw Exception("An Error Occured!");
      }
      UserModel user = UserModel.fromJson(response.data);
      applicationUserModel = user;

      return true;
    } catch (e) {
      return false;
    }
  }

  ///MARK: POST REGISTER USER
  @override
  Future<UIResult> register(map) async {
    try {
      final response = await _client.postMethod(
        requestMap["register"],
        value: map,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      UserModel user = UserModel.fromJson(response.data);

      applicationUserModel = user;

      return UIResult(success: true, message: "Register Succesful");
    } catch (e) {
      print("Error at register -> $e");
      return UIResult(success: false, message: "User Already Exists!");
    }
  }

  ///MARK: POST LOGIN USER
  @override
  Future<UIResult> login(map) async {
    try {
      final response = await _client.postMethod(
        requestMap["login"],
        value: map,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      UserModel user = UserModel.fromJson(response.data);

      applicationUserModel = user;
      return UIResult(success: true, message: "Login Succesful");
    } catch (e) {
      print("Error at login -> $e");
      return UIResult(
        success: false,
        message: "Please check your\nEmail or Password!",
      );
    }
  }

  ///MARK: GET USERS LIST
  @override
  Future<List<UserModel>> getUsers({required token}) async {
    try {
      //final response = await dio.get("https://cycleon.onrender.com/api/users/list");
      final response = await _client.getMethod(
        requestMap["list"],
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      List<UserModel>? users = RestUserModel.fromJson(response.data).data;
      if (users == null) {
        throw Exception("An Error Occured!");
      }
      return users;
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return [];
  }

  ///MARK: GET USER BY ID
  @override
  Future<UserModel> getById({required id, required token}) async {
    try {
      final response = await _client.getMethod(
        "${requestMap["getbyid"]}/$id",
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return UserModel.fromJson(response.data);
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return UserModel();
  }

  @override
  Future<UserModel> update(
    Map map, {
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.putMethod(
        "${requestMap["update"]}/$id",
        value: map,
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return UserModel.fromJson(response.data);
    } catch (e) {
      print("Error at -> getById: $e");
    }
    return UserModel();
  }

  @override
  Future<bool> deleteById({
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.deleteMethod(
        "${requestMap["deletebyid"]}/$id",
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

  @override
  Future<List<UserModel>> getFriends({
    required String id,
    required String token,
  }) async {
    try {
      final response = await _client.getMethod(
        "${requestMap["get-friends"]}/$id",
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return (response.data['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Error at -> getFriends: $e");
    }
    return [];
  }

  @override
  Future<bool> removeFriend({
    required String id,
    required String friendId,
    required String token,
  }) async {
    try {
      final response = await _client.deleteMethod(
        "${requestMap["remove-friend"]}/$id/$friendId",
        token: token,
      );
      if (response == null) {
        throw Exception("An Error Occured!");
      }
      return true;
    } catch (e) {
      print("Error at -> removeFriend: $e");
    }
    return false;
  }
}
