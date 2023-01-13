import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Client/Controller/weather_controller.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';

void main() {
  group("Weather Test", () {
    late WeatherController weatherController;

    setUp(() {
      weatherController = WeatherController();
    });

    test("current-weather", () async {
      WeatherBasicModel model = await weatherController.getWeatherByLatLang(
          lat: 39.769482, lang: 30.508678);
      
      expectLater(model.name, "Eskişehir");
      expectLater(model.mainModel!.temp, 277.1);
      expectLater(model.windModel!.speed, 3.09);
    });
  });
}
