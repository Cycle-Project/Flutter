import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WeatherState {
  final WeatherBasicModel? model;

  WeatherState(this.model);

  String get name => model?.name ?? "";
  String get temperature =>
      ((model?.mainModel?.temp ?? 273) - 273).toStringAsFixed(2);
  String get icon => model?.weatherModel?.first.icon ?? "";
  String get main => model?.weatherModel?.first.main ?? "";
  String get windSpeed => "${model?.windModel?.speed ?? ""} km/h";
  String get humidity => "${model?.mainModel?.humidity ?? ""} %";
}

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({
    Key? key,
    required this.dateToday,
    required this.state,
  }) : super(key: key);
  final String dateToday;
  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    const style16 = TextStyle(fontSize: 16);
    const style24 = TextStyle(fontSize: 24);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(state.name),
                const Spacer(),
                Text(dateToday),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 140,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: state.icon == ""
                      ? const SizedBox.square(dimension: 160)
                      : Image.network(
                          'https://openweathermap.org/img/wn/'
                          '${state.icon}'
                          '@4x.png',
                          width: 160,
                          height: 160,
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.windSpeed),
                        const SizedBox(width: 8),
                        const Icon(PhosphorIcons.windBold),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.humidity),
                        const SizedBox(width: 8),
                        const Icon(PhosphorIcons.drop),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(state.main, style: style16),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(PhosphorIcons.thermometer),
                        const SizedBox(width: 8),
                        Text("${state.temperature} °C", style: style24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
