import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';

mixin LandingPageInteractions {
  final UserController _userController = UserController();
  final FriendsController friendsController = FriendsController();

  dispose() {
    friendsController.disconnect();
    friendsController.dispose();
    _userController.dispose();
  }

  Future<UserModel?> getUserById(context) async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getById(id: id, token: token);
  }

  exitFromApp(context) async {
    if (await showQuestionDialog(context, "Dou you want to exit?")) {
      await CacheManager.remove(tag: "user_id");
      await CacheManager.remove(tag: "user_token");
      dispose();
      return true;
    }
    return false;
  }

  Future<List<UserModel>?> getFriends() async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getFriends(id: id, token: token);
  }

  Future<UserModel?> addFriend(String friendId) async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.addFriend(
      id: id,
      friendId: friendId,
      token: token,
    );
  }

  Future<bool> removeFriend(String friendId) async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return false;
    }
    await _userController.removeFriend(
      id: id,
      friendId: friendId,
      token: token,
    );
    return true;
  }
}
