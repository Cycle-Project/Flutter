class ClientConstants {
  static const String _weatherKey = "1f3413676a6ff7bcae401502cb9cd820";
  static const String baseUrl = "https://cycleon.onrender.com/api";
  static const String _baseUrl = "https://cycleon.onrender.com";
  static const String _url = "$_baseUrl/api";
  static const Map paths = {
    "users": {
      // POST @body
      "register": "$_url/users/register",

      // POST @body
      "login": "$_url/users/login",

      // GET
      "list": "$_url/users/list",

      // GET @param id
      "getbyid": "$_url/users/getbyid",

      // PUT @param id @body
      "update": "$_url/users/update",

      // DELETE @param id
      "deletebyid": "$_url/users/deletebyid",
    },
    "route": {
      // GET
      "list": "$_url/route/list",

      // POST @body{Route}
      "create-route": "$_url/route/create-route",

      // PUT @param id @body{Position}
      "add-position": "$_url/route/add-position",

      // PUT @param id @body{Route}
      "update": "$_url/route/update",

      // DELETE @param id
      "deletebyid": "$_url/route/deletebyid",
    },
    "weather": {
      "currentWeather": "https://api.openweathermap.org/data/2.5/weather?lat=10.99&lon=44.34&appid=$_weatherKey",
    }
  };
}
