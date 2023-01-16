// ignore_for_file: avoid_print

import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class WeatherController with IWeather {
  late Client _client;
  late Map _requestMap;

  WeatherController() {
    _client = Client();
    _requestMap = ClientConstants.paths["weather"];
  }

  @override
  Future<WeatherBasicModel> getWeatherByLatLang(
      {required double lat, required double lang}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["currentWeather"] +
            "lat=$lat&lon=$lang&appid=${Constants.openWeatherKey}",
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      return WeatherBasicModel.fromJson(response.data);
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return WeatherBasicModel();
  }
}
