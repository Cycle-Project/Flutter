import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Client/Models/user_model.dart';

mixin IUser {
  ///Servisle beraber, View ekranında da nasıl kullanılabileceğinin örnek kodu var elimde.
  Future<List<UserModel>> getUsers({required String token});
  Future<UserModel> getById({required String id, required String token});

  Future<UIResult> register(Map map);
  Future<UIResult> login(Map map);
}

class UIResult {
  final bool success;
  final String message;

  UIResult({required this.success, required this.message});
}

mixin IWeather {
  Future<WeatherBasicModel> getWeatherByLatLang({required double lat, required double lang});
}
