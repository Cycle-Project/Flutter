import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/ViewModel/plan_route_view_model_weather.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:lottie/lottie.dart';

class WeatherContainer extends HookWidget {
  final MapsProvider mapsProvider;
  final PlanRouteProvider provider;

  const WeatherContainer({
    Key? key,
    required this.mapsProvider,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlanRouteViewModelWeather vmWeather = PlanRouteViewModelWeather(
      context: context,
      provider: provider,
      mapsProvider: mapsProvider,
    );

    final destinationTemp = useState("");
    final sourceTemp = useState("");
    final sourceName = useState("");
    final sourceIcon = useState("");
    final sourceMain = useState("");
    final sourceWindSpeed = useState("");
    final sourceHum = useState("");

    useEffect(() {
      Future.microtask(() async {
        destinationTemp.value = await vmWeather.destinationTemp;
        sourceTemp.value = await vmWeather.sourceTemp;
        sourceName.value = await vmWeather.sourceName;
        sourceIcon.value = await vmWeather.sourceIcon;
        sourceMain.value = await vmWeather.sourceMain;
        sourceWindSpeed.value = await vmWeather.sourceWindSpeed;
        sourceHum.value = await vmWeather.sourceHum;
      });
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.my_location, color: Colors.greenAccent),
                    Text(sourceName.value),
                  ],
                ),
                Text(vmWeather.dateToday),
                Text("${sourceTemp.value}°C"),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/w/${sourceIcon.value}.png',
                ),
                Text(sourceMain.value),
                Row(
                  children: [
                    const Icon(Icons.cloud),
                    const Text("Wind"),
                    Text(sourceWindSpeed.value),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.water_drop_sharp),
                    const Text("Hum"),
                    Text(sourceHum.value),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
