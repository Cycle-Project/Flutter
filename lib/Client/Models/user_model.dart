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

  UserModel({
    this.name,
    this.email,
    this.id,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'email': email,
    'password': password,
  };
}
