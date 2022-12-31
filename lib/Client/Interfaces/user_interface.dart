import 'package:geo_app/Client/Models/user_model.dart';
mixin IUser {
  ///Servisle beraber, View ekranında da nasıl kullanılabileceğinin örnek kodu var elimde.
  Future<List<UserModel>> getUsers();
  Future<UserModel> register(Map map);
  Future<UserModel> login(Map map);
  Future<UserModel> getById(String id);
}