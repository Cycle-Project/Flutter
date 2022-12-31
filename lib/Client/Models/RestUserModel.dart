import 'package:geo_app/Client/Models/user_model.dart';

class RestUserModel {
  bool? success;
  int? count;
  List<UserModel>? data;

  RestUserModel({
    this.success,
    this.count,
    this.data,
  });

  RestUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    count = json['count'];
    data = List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'count': count,
    'data': List<UserModel>.from(data!.map((x) => x.toJson())),
  };
}
