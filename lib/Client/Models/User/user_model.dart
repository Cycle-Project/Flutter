//
//  user_model.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? token;
  List<String>? friends;

  UserModel({
    this.name,
    this.email,
    this.id,
    this.password,
    this.token,
    this.friends,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    friends = (json['friends'] as List?)?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'token': token,
        'friends': friends,
      };
}
