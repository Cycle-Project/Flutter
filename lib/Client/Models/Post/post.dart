import 'package:geo_app/Client/Models/Post/comment.dart';

class Post {
  final String? id;
  final List<Comment>? comments;
  final List<String>? likes;
  final String? routeId;

  Post({
    this.id,
    this.comments,
    this.likes,
    this.routeId,
  });

  factory Post.fromJson(Map json) => Post(
        id: json['id'],
        comments: json['comments'],
        likes: json['likes'],
        routeId: json['routeId'],
      );
  Map toJson() => {
        'id': id,
        'comments': comments,
        'likes': likes,
        'routeId': routeId,
      };
}
