class ClientConstants {
  static const String baseUrl = "https://cycleon.onrender.com";
  static const String socketUrl = "https://cycleon-socket.onrender.com";
  static const String url = "$baseUrl/api";
  static const String _baseGoogleMapsURL =
      "https://maps.googleapis.com/maps/api";
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

      // DELETE @param id  @param fid
      "remove-friend": "$url/users/remove-friend",
    },
    "route": {
      // GET
      "list": "$url/route/list",

      // GET
      "routes-of": "$url/route/routes-of",

      // POST @body{Route}
      "create-route": "$url/route/create-route",

      // PUT @param id @body{Position}
      "add-position": "$url/route/add-position",

      // PUT @param id @body{Route}
      "update": "$url/route/update",

      // DELETE @param id
      "deletebyid": "$url/route/deletebyid",
    },
    "post": {
      // GET
      "list": "$url/post/list",

      // GET
      "post": "$url/post/post",

      // POST
      "add-post": "$url/post/add-post",

      // PUT @param id @body{Route}
      "update": "$url/post/update",

      // PUT @param id @body{Route}
      "like": "$url/post/like",

      // PUT @param id @body{Route}
      "comment": "$url/post/comment",

      // DELETE @param id
      "deletebyid": "$url/route/deletebyid",
    },
    "weather": {
      // GET @param key
      "currentWeather": "https://api.openweathermap.org/data/2.5/weather?",
    },
    "googleMaps": {
      "distanceTwoLocate": "$_baseGoogleMapsURL/distancematrix/json?",
      "elevation": "$_baseGoogleMapsURL/elevation/json?",
    }
  };
}
