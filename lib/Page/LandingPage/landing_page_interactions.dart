import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/user_model.dart';

mixin LandingPageInteractions {
  final UserController _userController = UserController();

  Future<UserModel?> getUserById(context) async {
    String? id = await CacheManager.getSharedPref(tag: "user_id");
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    if (id == null || token == null) {
      return null;
    }
    return await _userController.getById(id: id, token: token);
  }
}
