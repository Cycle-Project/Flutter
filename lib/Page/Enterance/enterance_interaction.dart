import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/GPS/location_service.dart';

mixin EnteranceInteraction {
  final UserController userController = UserController();

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, String> map = {
      "name": name,
      "email": email,
      "password": password,
    };
    await userController.register(map);
  }

  Future<UserModel> login(
      context, {
        required String email,
        required String password,
      }) async {
    Map<String, String> map = {
      "email": email,
      "password": password,
    };
    UserModel user = await userController.login(map);
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