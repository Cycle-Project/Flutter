import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Interfaces/ui_result.dart';
import 'package:geo_app/GPS/location_service.dart';
import 'package:geo_app/Page/OnboardingPage/on_boarding_page.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';

mixin EnteranceInteraction {
  final UserController _userController = UserController();

  Future<bool> register(
    context, {
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, String> map = {
      "name": name,
      "email": email,
      "password": password,
    };
    UIResult registerResult = await _userController.register(map);
    if (!registerResult.success) {
      showFailDialog(context, registerResult.message);
      return false;
    }
    await showSuccessDialog(context, registerResult.message);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => OnboardingPage(),
      ),
      (r) => r.isFirst,
    );

    return true;
  }

  Future<bool> login(
    context, {
    required String email,
    required String password,
  }) async {
    Map<String, String> map = {
      "email": email,
      "password": password,
    };
    UIResult loginResult = await _userController.login(map);
    if (!loginResult.success) {
      showFailDialog(context, loginResult.message);
      return false;
    }
    await showSuccessDialog(context, loginResult.message)
        .then((_) => _navigateToApp(context));
    return true;
  }

  Future loggedBefore(context) async {
    if (await _userController.cachedLogin()) {
      print("loggedBefore");
      _navigateToApp(context);
    }
    print("didn't loggedBefore");
  }

  Future googleLogin(context) async {
    //UserModel user = UserModel();
    _navigateToApp(context);
  }

  Future guestLogin(context) async {
    //UserModel user = UserModel();
    _navigateToApp(context);
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
