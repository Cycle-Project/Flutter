import 'package:flutter/material.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/GPS/location_service.dart';

mixin EnteranceInteraction {
  final Client _client = Client();
  UserModel? _userModel;

  login(context, isValidated, email, password) async {
    if (isValidated) {
      _userModel =
      await _client.loginUser(email: email, password: password);
      if (_userModel == null) {
        //TODO: Burada Alert Gösterilecek Bab ba!
        return;
      }

      if (_userModel!.id != null) {
        CacheManager.saveSharedPref(tag: "userID", value: _userModel!.id!);
      }
      if (_userModel!.token != null) {
        CacheManager.saveSharedPref(tag: "userToken", value: _userModel!.token!);
      }
      _loginApp(context);
    }
  }

  googleLogin() {
    print("google");
  }

  guestLogin(context) {
    _loginApp(context);
  }

  register() {
    print("register");
  }

  forgetPassword() {
    print("forget");
  }

  _loginApp(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LocationService(),
      ),
      (r) => r.isFirst,
    );
  }
}
