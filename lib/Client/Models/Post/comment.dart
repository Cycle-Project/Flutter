class Comment {
  final String? userId;
  final String? comment;

  Comment({
    required this.userId,
    required this.comment,
  });

  factory Comment.fromJson(Map json) => Comment(
        userId: json['userId'],
        comment: json['comment'],
      );
  Map toJson() => {
        'userId': userId,
        'comment': comment,
      };
}
