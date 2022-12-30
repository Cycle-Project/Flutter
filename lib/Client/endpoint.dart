//
//  endpoint.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

class ClientConstants {
  static const String baseUrl = "https://cycleon.onrender.com/api";
  static const Map paths = {
    "users": {
      "list": "$baseUrl/users/list",
      "register": "$baseUrl/users/register",
      "login": "$baseUrl/users/login",
    },
  };
}
