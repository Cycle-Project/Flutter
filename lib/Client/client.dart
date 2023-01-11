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

  dispose() {
    dio.close();
  }

  ///MARK: GENERIC GET
  Future<Response?> getMethod(String path, {String? token}) async {
    final response = await dio.get(
      path,
      options:
          token == null ? null : Options(headers: {'x-access-token': token}),
    );
    //200
    if (response.statusCode == HttpStatus.ok) {
      return response;
    }
    print("${response.statusMessage}");
    throw Exception("Error: ${response.statusMessage}");
  }

  ///MARK: GENERIC POST
  Future<Response?> postMethod(
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
    //200 //201
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      return response;
    }
    print("${response.statusMessage}");
    throw Exception("Error: ${response.statusMessage}");
  }

  ///MARK: GENERIC PUT
  Future<Response?> putMethod(
    String path, {
    required Map value,
    String? token,
  }) async {
    final response = await dio.put(
      path,
      data: value,
      options:
          token == null ? null : Options(headers: {'x-access-token': token}),
    );

    //200 //201
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      return response;
    }
    print("${response.statusMessage}");
    throw Exception("Error: ${response.statusMessage}");
  }

  ///MARK: GENERIC DELETE
  Future<Response?> deleteMethod(String path, {String? token}) async {
    final response = await dio.delete(
      path,
      options:
          token == null ? null : Options(headers: {'x-access-token': token}),
    );
    //200
    if (response.statusCode == HttpStatus.ok) {
      return response;
    }
    print("${response.statusMessage}");
    throw Exception("Error: ${response.statusMessage}");
  }
}
