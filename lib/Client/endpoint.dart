//
//  endpoint.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

class ClientConstants {
  static const String _BASE_URL = "https://cycleon.onrender.com/api";
  static Map<String, String> paths = {
    "listUser": "$_BASE_URL/users/list",
    "registerUser": "$_BASE_URL/users/register",
    "loginUser": "$_BASE_URL/users/login",
  };
}