class ClientConstants {
  static const String _weatherKey = "1f3413676a6ff7bcae401502cb9cd820";
  static const String baseUrl = "https://cycleon.onrender.com/api";
  static const String _baseUrl = "https://cycleon.onrender.com";
  static const String url = "$_baseUrl/api";
  static const Map paths = {
    "users": {
      // POST @body
      "register": "$url/users/register",

      // POST @body
      "login": "$url/users/login",

      // GET
      "list": "$url/users/list",

      // GET @param id
      "getbyid": "$url/users/getbyid",

      // PUT @param id @body
      "update": "$url/users/update",

      // DELETE @param id
      "deletebyid": "$url/users/deletebyid",

      // GET @param id
      "get-friends": "$url/users/get-friends",

      // PUT @param id @body(friend_id)
      "add-friend": "$url/users/add-friend",

      // DELETE @param id  @param fid
      "remove-friend": "$url/users/remove-friend",
    },
    "route": {
      // GET
      "list": "$url/route/list",

      // POST @body{Route}
      "create-route": "$url/route/create-route",

      // PUT @param id @body{Position}
      "add-position": "$url/route/add-position",

      // PUT @param id @body{Route}
      "update": "$url/route/update",

      // DELETE @param id
      "deletebyid": "$url/route/deletebyid",
    },
    "weather": {
      "currentWeather":
          "https://api.openweathermap.org/data/2.5/weather?lat=10.99&lon=44.34&appid=$_weatherKey",
    }
  };
}
