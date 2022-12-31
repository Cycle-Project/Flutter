// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/main.dart';

void main() {
  UserController userController = UserController();

  test("User List", () async {
    // Given
    List<UserModel> userList = [];
    expect(userList, isEmpty);

    // When
    userList = await userController.getUsers();

    // Then
    expect(userList, isNotEmpty);
  });

  test("Uset Get By Id", () async {
    // Given
    UserModel userModel = UserModel();

    //When
    userModel = await userController.getById("63afc9334dd4c2b74aef05cf");

    //Then
    expectLater(userModel.name, "Omer");
  });

  test("User Login", () async {
    // Given
    String? id;
    //expect(id, null);

    // When
    Map<String, String> map = {
      "email": "omer@gmail.com",
      "password": "Qwe123.",
    };

    await userController.login(map);
    id = await CacheManager.getSharedPref(tag: "user_id");

    print(id);
    // Then

    //expect(id, "63afc9334dd4c2b74aef05cf");
    //expect(userModel.password, temp.password);
  });
}
