import 'package:geo_app/Client/Interfaces/ui_result.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';

mixin IUser {
  Future<UIResult> register(Map map);
  Future<UIResult> login(Map map);
  Future<List<UserModel>> getUsers({
    required String token,
  });
  Future<UserModel> getById({
    required String id,
    required String token,
  });
  Future<UserModel> update(
    Map map, {
    required String id,
    required String token,
  });
  Future<bool> deleteById({
    required String id,
    required String token,
  });
}
