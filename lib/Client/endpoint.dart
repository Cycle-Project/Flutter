//
//  endpoint.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

class ClientConstants {
  static String BASE_URL = "https://cycleon.onrender.com/api";

}

enum EndpointEnum {
  userList,
  registerUser,
}

extension EnpointsEnumExtension on EndpointEnum {

  String get getPath {
    switch (this) {
      case EndpointEnum.userList:
        return "/users/list";
      case EndpointEnum.registerUser:
        return "/users/register";
      default:
        return "404 URL";
    }
  }
}