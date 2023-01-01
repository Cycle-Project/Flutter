//
//  client.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';

class Client {
  final dio = Dio();
  /* 'Authorization' */
  ///MARK: GENERIC GET
  Future getMethod(String path, {String? token}) async {
    final response = await dio.get(
      path,
      options:
          token == null ? null : Options(headers: {'x-access-token': token}),
    );

    switch (response.statusCode) {
      case HttpStatus.ok: //200
        return response;
      default:
        print("${response.statusMessage}");
        throw Exception("Error: ${response.statusMessage}");
    }
  }

  ///MARK: GENERIC POST
  Future postMethod(
    String path, {
    required Map value,
    String? token,
  }) async {
    final response = await dio.post(
      path,
      data: value,
      options:
          token == null ? null : Options(headers: {'x-access-token': token}),
    );

    switch (response.statusCode) {
      case HttpStatus.ok: //200
        return response;
      case HttpStatus.created: //201
        return response;
      //case HttpStatus.badRequest:     //400
      default:
        print("${response.statusMessage}");
        throw Exception("Error: ${response.statusMessage}");
    }
  }
}
