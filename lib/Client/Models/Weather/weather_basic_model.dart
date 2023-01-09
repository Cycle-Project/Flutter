import 'package:geo_app/Client/Models/Weather/main_model.dart';
import 'package:geo_app/Client/Models/Weather/weather_model.dart';
import 'package:geo_app/Client/Models/Weather/wind_model.dart';

class WeatherBasicModel {
  String? name;
  List<WeatherModel>? weatherModel;
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
    if (json['weather'] != null) {
      weatherModel = <WeatherModel>[];
      json['weather'].forEach((v) {
        weatherModel!.add(WeatherModel.fromJson(v));
      });
    }
    windModel = json['wind'] != null ? WindModel.fromJson(json['wind']) : null;
    mainModel = json['main'] != null ? MainModel.fromJson(json['main']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (weatherModel != null) {
      data['weather'] = weatherModel!.map((v) => v.toJson()).toList();
    }
    if (windModel != null) {
      data['wind'] = windModel!.toJson();
    }
    if (mainModel != null) {
      data['main'] = mainModel!.toJson();
    }
    return data;
  }
}
