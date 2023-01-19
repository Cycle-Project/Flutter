import 'package:geo_app/Client/Models/Post/comment.dart';
import 'package:geo_app/Client/Models/Post/post.dart';

mixin IPost {
  /* 
      // GET
      "list": "$url/post/list",

      // GET
      "post": "$url/post/post",

      // POST
      "add-post": "$url/post/add-post",

      // PUT @param id @body{Route}
      "update": "$url/post/update",

      // PUT @param id @body{Route}
      "like": "$url/post/like",

      // PUT @param id @body{Route}
      "comment": "$url/post/comment",

      // DELETE @param id
      "deletebyid": "$url/route/deletebyid", */
  Future<List<Post>> list({
    required String token,
  });
  Future<Post> post({
    String? id,
    String? routeId,
    String? userId,
    required String token,
  });
  Future<Post> addRoute(
    Map map, {
    required String token,
  });
  Future<Post> update(
    Map map, {
    required String id,
    required String token,
  });
  Future<Post> like({
    required String id,
    required String userId,
    required String token,
  });
  Future<Post> comment(
    Comment comment, {
    required String id,
    required String token,
  });
  Future<bool> deleteById({
    required String id,
    required String token,
  });
}
