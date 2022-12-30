//
//  client.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geo_app/Client/IClient.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/error_model.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Client/endpoint.dart';

class Client extends IClient {
  final dio = Dio();

  ///MARK: GENERIC GET
  dynamic _getDioRequest(String path) async {
    final response = await dio.get(path);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        return ErrorModel(response.statusMessage.toString());
    }
  }

  ///MARK: GET USER LIST
  @override
  Future<List<UserModel>> getHttpUserModel() async {
    final response = await _getDioRequest(ClientConstants.paths["listUser"]!);
    if (response is List) {
      return response.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw response;
    }
  }

  ///MARK: POST Register User
  @override
  Future<UserModel?> registerUser({required UserModel userModel}) async {
    UserModel? retrievedUser;
    try {
      Response response = await dio.post(
        ClientConstants.paths["registerUser"]!,
        data: userModel.toJson(),
      );

      print("Created");
      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  ///MARK: POST Login User
  @override
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    try {
      Response response = await dio.post(
        ClientConstants.paths["loginUser"]!,
        data: data,
        options: Options(
          headers: {'X-LoginRadius-Sott': 'YOUR_SOTT_KEY'},
        ),
      );
      final body = response.data;
      if (response.statusCode == 200) {
        return UserModel(
          id: body['_id'],
          token: body['token'],
          name: body['name'],
          password: body['password'],
          email: body['email'],
        );
      } else {
        return null;
      }
    } on DioError catch(e) {
      return null;
    }
  }
}
