import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Client/Interfaces/ui_result.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';

mixin IUser {
  Future<bool> cachedLogin();
  Future<UIResult> register(Map map);
  Future<UIResult> login(Map map);
  Future<List<UserModel>> getUsers({
    required String token,
  });
  Future<UserModel> getById({
    required String id,
    required String token,
  });
  Future<UserModel> update(
    Map map, {
    required String id,
    required String token,
  });
  Future<bool> deleteById({
    required String id,
    required String token,
  });
}

mixin IWeather {
  Future<WeatherBasicModel> getWeatherByLatLang({required double lat, required double lang});
}
