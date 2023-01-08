import 'package:geo_app/Client/Models/Weather/main_model.dart';
import 'package:geo_app/Client/Models/Weather/weather_model.dart';
import 'package:geo_app/Client/Models/Weather/wind_model.dart';

class WeatherBasicModel {
  String? name;
  WeatherModel? weatherModel;
  WindModel? windModel;
  MainModel? mainModel;

  WeatherBasicModel({
    this.name,
    this.weatherModel,
    this.windModel,
    this.mainModel,
  });

  WeatherBasicModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weatherModel = json['weather'];
    windModel = json['windModel'];
    mainModel = json['mainModel'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'weather': weatherModel,
    'windModel': windModel,
    'mainModel': mainModel,
  };
}

