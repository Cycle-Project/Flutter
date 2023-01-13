import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Interfaces/ui_result.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/main.dart';

void main() {
  group("User Unit Test", () {
    late UserController userController;

    setUp(() {
      userController = UserController();
    });

    test("register", () async {
      UIResult uiResult = await userController.register({
        "name": "TestName",
        "email": "testmailaccountasd@gmail.com",
        "password": "qwe123"
      });
      expect(uiResult.success, false);
    });

    test("login", () async {
      UIResult uiResult = await userController.login({
        "email": "yahya@gmail.com",
        "password": "qwe123",
      });
      expect(uiResult.success, true);
    });

    test("userlist", () async {
      expect(applicationUserModel, isNotNull);
      await userController.login({
        "email": "yahya@gmail.com",
        "password": "qwe123",
      });

      List<UserModel> list =
          await userController.getUsers(token: applicationUserModel!.token!);
      expectLater(list.isEmpty, false);
    });
    test("getById", () async {
      expect(applicationUserModel, isNotNull);
      await userController.login({
        "email": "yahya@gmail.com",
        "password": "qwe123",
      });

      UserModel userModel = await userController.getById(
        id: applicationUserModel!.id.toString(),
        token: applicationUserModel!.token.toString(),
      );

      expectLater(userModel.id, "63b17cb6e0fec3e19def2359");
      expectLater(userModel.name, "Yahya Bekir");
      expectLater(userModel.email, "yahya@gmail.com");
    });

    test("getById", () async {
      expect(applicationUserModel, isNotNull);
      await userController.login({
        "email": "yahya@gmail.com",
        "password": "qwe123",
      });

      UserModel userModel = await userController.getById(
        id: applicationUserModel!.id.toString(),
        token: applicationUserModel!.token.toString(),
      );

      expectLater(userModel.id, "63b17cb6e0fec3e19def2359");
      expectLater(userModel.name, "Yahya Bekir");
      expectLater(userModel.email, "yahya@gmail.com");
    });

    test("getById", () async {
      expect(applicationUserModel, isNotNull);
      await userController.login({
        "email": "yahya@gmail.com",
        "password": "qwe123",
      });

      UserModel userModel = await userController.getById(
        id: applicationUserModel!.id.toString(),
        token: applicationUserModel!.token.toString(),
      );

      expectLater(userModel.id, "63b17cb6e0fec3e19def2359");
    });
  });
}
