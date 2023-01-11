import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';

mixin LandingPageInteractions {
  final UserController _userController = UserController();

  dispose() {
    _userController.dispose();
  }

  Future<UserModel?> getUserById(context, {String? userId}) async {
    String? id = userId ?? await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getById(id: id, token: token);
  }

  Future<List<UserModel>?> getUsers(context, bool withoutCurrent) async {
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (token == null) {
      return null;
    }
    List<UserModel>? users = await _userController.getUsers(token: token);
    if (withoutCurrent) {
      UserModel? current = await getUserById(context);
      users.removeWhere((e) => e.id == current!.id);
    }
    return users;
  }

  exitFromApp(context) async {
    if (await showQuestionDialog(context, "Dou you want to exit?")) {
      await CacheManager.remove(tag: "user_id");
      await CacheManager.remove(tag: "user_token");
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
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getFriends(id: id, token: token);
  }

  Future removeFriend(context, String friendId) async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
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
