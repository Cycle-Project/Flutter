import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_weather.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class WeatherState {
  final String destinationTemp;
  final String sourceTemp;
  final String sourceName;
  final String sourceIcon;
  final String sourceMain;
  final String sourceWindSpeed;
  final String sourceHum;

  WeatherState({
    this.destinationTemp = "",
    this.sourceTemp = "",
    this.sourceName = "",
    this.sourceIcon = "",
    this.sourceMain = "",
    this.sourceWindSpeed = "",
    this.sourceHum = "",
  });
}

class WeatherContainer extends HookWidget {
  const WeatherContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);
    final destinationWeather = useState<WeatherBasicModel?>(null);
    final sourceWeather = useState<WeatherBasicModel?>(null);

    PlanRouteViewModelWeather vmWeather = PlanRouteViewModelWeather(
      provider: provider,
      mapsProvider: mapsProvider,
    );
    final state = useState(WeatherState());

    useEffect(() {
      if (sourceWeather.value == null) {
        state.value = WeatherState();
        Future.microtask(() async {
          sourceWeather.value =
              await vmWeather.weatherController.getWeatherByLatLang(
            lat: vmWeather.sourceProvider.latitude,
            lang: vmWeather.sourceProvider.longitude,
          );
          destinationWeather.value =
              await vmWeather.weatherController.getWeatherByLatLang(
            lat: vmWeather.destinationProvider.latitude,
            lang: vmWeather.destinationProvider.longitude,
          );
        });
      } else {
        state.value = WeatherState(
          destinationTemp: vmWeather.destinationTemp(sourceWeather.value!),
          sourceTemp: vmWeather.sourceTemp(sourceWeather.value!),
          sourceName: vmWeather.sourceName(sourceWeather.value!),
          sourceIcon: vmWeather.sourceIcon(sourceWeather.value!),
          sourceMain: vmWeather.sourceMain(sourceWeather.value!),
          sourceWindSpeed: vmWeather.sourceWindSpeed(sourceWeather.value!),
          sourceHum: vmWeather.sourceHum(sourceWeather.value!),
        );
      }
      return null;
    }, [sourceWeather.value]);

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
                Text(state.value.sourceName),
                const Spacer(),
                Text(vmWeather.dateToday),
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
                  child: state.value.sourceIcon == ""
                      ? const SizedBox.square(dimension: 160)
                      : Image.network(
                          'https://openweathermap.org/img/wn/'
                          '${state.value.sourceIcon}'
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
                        Text(state.value.sourceWindSpeed),
                        const SizedBox(width: 8),
                        const Icon(PhosphorIcons.windBold),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.value.sourceHum),
                        const SizedBox(width: 8),
                        const Icon(PhosphorIcons.dropHalfBottomFill),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(state.value.sourceMain, style: style16),
                    const Spacer(),
                    Text("${state.value.sourceTemp} °C", style: style24),
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
