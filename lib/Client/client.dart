//
//  client.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geo_app/Client/IClient.dart';
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

  ///MARK: GET USER
  ///Endpoint şimdilik gereksiz
  @override
  Future<List<UserModel>> getHttpUserModel() async {
    final response = await _getDioRequest(EndpointEnum.userList.getPath);
    if (response is List) {
      return response.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw response;
    }
  }

  ///MARK: POST
  @override
  Future<UserModel?> registerUser({required UserModel userModel}) async {
    UserModel? retrievedUser;
    try {
      Response response = await dio.post(
        ClientConstants.BASE_URL + EndpointEnum.registerUser.getPath,
        data: userModel.toJson(),
      );

      print(ClientConstants.BASE_URL + EndpointEnum.registerUser.getPath);
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      print("Created");
      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }
}