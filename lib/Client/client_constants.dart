class ClientConstants {
  static const String baseUrl = "https://cycleon.onrender.com/api";
  static const Map paths = {
    "users": {
      "list": "$baseUrl/users/list",
      "register": "$baseUrl/users/register",
      "login": "$baseUrl/users/login",
      "getById": "$baseUrl/users/getbyid",
    },
    "route": {
      "list": "$baseUrl/route/list",
      "add-route": "$baseUrl/route/add-route",
    },
  };
}
