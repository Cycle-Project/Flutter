//
//  IClient.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

import 'package:geo_app/Client/Models/user_model.dart';

abstract class IClient {
  ///Servisle beraber, View ekranında da nasıl kullanılabileceğinin örnek kodu var elimde.

  Future<List<UserModel>> getHttpUserModel();
  Future<UserModel?> registerUser({required UserModel userModel});
  Future<UserModel?> loginUser({required String email, required String password});
}
