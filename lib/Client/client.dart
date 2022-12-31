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

  ///MARK: GENERIC GET
  Future getMethod(String path) async {
    final response = await dio.get(path);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return response;
      default:
        throw Exception(response.statusMessage.toString());
    }
  }

  ///MARK: GENERIC POST
  Future postMethod({required String path, required Map value}) async {
    final response = await dio.post(path, data: value);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return response;
      case HttpStatus.created:
        return response;
      default:
        throw Exception(response.statusMessage.toString());
    }
  }
}