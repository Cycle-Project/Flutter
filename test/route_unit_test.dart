import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Client/Controller/route_controller.dart';
import 'package:geo_app/Client/Controller/user_controller.dart';
import 'package:geo_app/Client/Models/Route/route.dart';
import 'package:geo_app/main.dart';

void main() {
  group("Route Unit Test", () {
    late UserController userController;
    late RouteController routeController;

    setUp(() {
      routeController = RouteController();
      userController = UserController();
    });

    test("create-route", () async {
      expect(applicationUserModel, isNotNull);
      await userController
          .login({"email": "yahya@gmail.com", "password": "qwe123"});

      await routeController.createRoute({
        "positions": [
          {
            "latitude": "123123",
            "longitude": "123123",
            "altitude": "123123",
            "city": "TestDeneme"
          }
        ],
        "userMadeId": applicationUserModel!.id
      }, token: applicationUserModel!.token!);

      List<Route> routeList =
          await routeController.getRoutes(token: applicationUserModel!.token!);

      expectLater(routeList.last.positions!.last.latitude, "123123");
      expectLater(routeList.last.positions!.last.city, "TestDeneme");
      expectLater(routeList.last.positions!.last.longitude, "123123");
      expectLater(routeList.last.positions!.last.altitude, "123123");
    });

    //TODO: SADECE ID GÖNDERİYOR - POSTMANDE BİR SIKINTI YOK BABA
    test("add-position", () async {
      expect(applicationUserModel, isNotNull);
      await userController
          .login({"email": "yahya@gmail.com", "password": "qwe123"});

      await routeController.addPosition(
        {
          "positions": [
            {
              "latitude": "111",
              "longitude": "222",
              "altitude": "121212",
              "city": "omerfaruk",
            }
          ],
          "userMadeId": applicationUserModel!.id
        },
        token: applicationUserModel!.token!,
        id: "63c0fea2f27855cc5614b686",
      );

      List<Route> routeList =
          await routeController.getRoutes(token: applicationUserModel!.token!);

      for (var i in routeList) {
        if (i.id == "63c0fea2f27855cc5614b686") {
          // ignore: avoid_print
          print(i.positions!.last.city);
        }
      }
    });

    test("route-list", () async {
      expect(applicationUserModel, isNotNull);
      await userController
          .login({"email": "yahya@gmail.com", "password": "qwe123"});

      List<Route> routeList =
          await routeController.getRoutes(token: applicationUserModel!.token!);

      expectLater(routeList.isEmpty, false);
    });
  });
}
