class ClientConstants {
  static const String _weatherKey = "1f3413676a6ff7bcae401502cb9cd820";
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
    "weather": {
      "currentWeather": "https://api.openweathermap.org/data/2.5/weather?lat=10.99&lon=44.34&appid=$_weatherKey",
    }
  };
}
