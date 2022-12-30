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
  Future<T?> getMethod<T>(String path) async {
    final response = await dio.get<T?>(path);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        throw Exception(response.statusMessage.toString());
    }
  }

  ///MARK: GENERIC POST
  Future<T?> postMethod<T>({required String path, required Map value}) async {
    final response = await dio.post<T?>(path, data: value);

    switch (response.statusCode) {
      case HttpStatus.created:
        return response.data;
      default:
        throw Exception(response.statusMessage.toString());
    }
  }
}
