import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/main.dart';

mixin LandingPageInteractions {
  final UserController _userController = UserController();

  dispose() {
    _userController.dispose();
  }

  Future<UserModel?> getUserById(context, {required String userId}) async {
    String? id = userId;
    String? token = applicationUserModel?.token;
    if (token == null) {
      return null;
    }
    return await _userController.getById(id: id, token: token);
  }

  Future<List<UserModel>?> getUsers(context, bool withoutCurrent) async {
    String? token = applicationUserModel?.token;
    if (token == null) {
      return null;
    }
    List<UserModel>? users = await _userController.getUsers(token: token);
    if (withoutCurrent) {
      users.removeWhere((e) => e.id == applicationUserModel!.id);
    }
    return users;
  }

  exitFromApp(context) async {
    if (await showQuestionDialog(context, "Dou you want to exit?")) {
      dispose();
      _navigateToEnterence(context);
    }
  }

  _navigateToEnterence(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => EnterancePage(),
      ),
      (r) => r.isFirst,
    );
  }

  Future<List<UserModel>?> getFriends() async {
    String? id = applicationUserModel?.id;
    String? token = applicationUserModel?.token;
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getFriends(id: id, token: token);
  }

  Future removeFriend(context, String friendId) async {
    String? id = applicationUserModel?.id;
    String? token = applicationUserModel?.token;
    if (id == null || token == null) {
      return;
    }
    bool isSure = await showQuestionDialog(context, "Are you sure?");
    if (isSure) {
      await _userController.removeFriend(
        id: id,
        friendId: friendId,
        token: token,
      );
    }
  }
}
