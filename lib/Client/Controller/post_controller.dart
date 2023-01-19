// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/post_interface.dart';
import 'package:geo_app/Client/Models/Post/post.dart';
import 'package:geo_app/Client/Models/Post/comment.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';

class PostController with IPost {
  late Client _client;
  late Map _requestMap;

  PostController() {
    _client = Client();
    _requestMap = ClientConstants.paths["post"];
  }

  @override
  Future<Post> addRoute(Map map, {required String token}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["list"],
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      if (response.data['data'] == null) {
        throw Exception("An Error Occured!");
      }
      return Post.fromJson(response.data['data']);
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return Post();
  }

  @override
  Future<Post> comment(Comment comment,
      {required String id, required String token}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["list"],
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      if (response.data['data'] == null) {
        throw Exception("An Error Occured!");
      }
      return Post.fromJson(response.data['data']);
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return Post();
  }

  @override
  Future<bool> deleteById({required String id, required String token}) async {
    try {
      final response = await _client.deleteMethod(
        _requestMap["list"],
        token: token,
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      if (response.data['data'] == null) {
        throw Exception("An Error Occured!");
      }
      return true;
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return false;
  }

  @override
  Future<Post> like(
      {required String id, required String userId, required String token}) {
    // TODO: implement like
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> list({required String token}) async {
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
      return list.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return [];
  }

  @override
  Future<Post> post(
      {String? id, String? routeId, String? userId, required String token}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Post> update(Map map, {required String id, required String token}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
