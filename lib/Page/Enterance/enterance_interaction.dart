import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/GPS/location_service.dart';

mixin EnteranceInteraction {
  final UserController userController = UserController();

  Future<UserModel> login(
    context, {
    required String email,
    required String password,
  }) async {
    UserModel user = await userController.login({
      "email": email,
      "password": password,
    });
    _navigateToApp(context);
    return user;
  }

  Future<UserModel> googleLogin(context) async {
    UserModel user = UserModel();
    _navigateToApp(context);
    return user;
  }

  Future<UserModel> guestLogin(context) async {
    UserModel user = UserModel();
    _navigateToApp(context);
    return user;
  }

  Future<UserModel> register(context, {required UserModel userModel}) async {
    UserModel user = await userController.register(userModel.toJson());
    _navigateToApp(context);
    return user;
  }

  forgetPassword(context) {}

  _navigateToApp(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LocationService(),
      ),
      (r) => r.isFirst,
    );
  }
}
