import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Page/Enterance/Page/Components/custom_textformfield.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/google_maps_view_model.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/elevation_container.dart';
import 'package:geo_app/Page/LandingPage/map/route_mixin.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/speed_time_container.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/weather_container.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class InspectRouteBottomSheet extends HookWidget with RouteMixin {
  InspectRouteBottomSheet({
    Key? key,
    required this.isPlanning,
    this.route,
  }) : super(key: key);

  final bool isPlanning;
  final r.Route? route;

  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);
    GMViewModel gmvm = GMViewModel(
      provider: provider,
      mapsProvider: mapsProvider,
    );
    final weather = useState<WeatherBasicModel>(WeatherBasicModel());
    final titleController = useTextEditingController(text: route?.title ?? "");
    final notesController = useTextEditingController(text: route?.notes ?? "");

    useEffect(() {
      Future.microtask(() async {
        if (mapsProvider.currentLocation == null) return;
        weather.value = await gmvm.getWeather(LatLng(
          mapsProvider.currentLocation!.latitude!,
          mapsProvider.currentLocation!.longitude!,
        ));
      });
      return null;
    }, []);

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: .9,
      expand: false,
      builder: (context, scrollController) => ColoredBox(
        color: Constants.darkBluishGreyColor,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Wrap(
            children: [
              const Divider(
                height: 8,
                color: Constants.darkBluishGreyColor,
              ),
              if (provider.source == null || provider.destination == null)
                isPlanning ? const PlanningCard() : const Text("No Context")
              else ...[
                SpeedTimeContainer(gmvm: gmvm),
                if (isPlanning) const PlanningCard(),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _Field(
                        child: CustomTextFormField(
                          controller: titleController,
                          hintText: 'A Beautiful scenery',
                          labelText: 'Title',
                          showBorder: true,
                          validator: (value) =>
                              value!.isEmpty ? "Enter a Title" : null,
                        ),
                      ),
                      _Field(
                        child: CustomTextFormField(
                          controller: notesController,
                          hintText: 'Must take a Camera with you...',
                          labelText: 'Notes',
                          showBorder: true,
                          minLines: 3,
                          maxLines: 6,
                          validator: (value) =>
                              value!.isEmpty ? "Give Some Notes" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                WeatherContainer(
                  dateToday: gmvm.dateToday(),
                  state: WeatherState(weather.value),
                ),
                ElevationContainer(
                  onTouch: (i) async {
                    weather.value = await gmvm.getWeather(
                      mapsProvider.polylineCoordinates[i],
                    );
                  },
                  gmvm: gmvm,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: InkWell(
                    onTap: () async {
                      if (!(formKey.currentState!.validate())) return;
                      r.Route newRoute = (route ?? r.Route())
                        ..positions = mapsProvider.polylineCoordinates
                            .map((e) => Position.fromLatLng(e))
                            .toList()
                        ..userMadeId = applicationUserModel.id
                        ..title = titleController.text
                        ..notes = notesController.text;
                      await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Route'),
                          content: SingleChildScrollView(
                            child: Text(
                              newRoute.toJson().toString(),
                            ),
                          ),
                        ),
                      ).then((value) async {
                        if (isPlanning) {
                          await save(context, newRoute);
                        } else {
                          await share(context, newRoute);
                        }
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Constants.primaryColor.withOpacity(.8),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          Icon(
                            isPlanning ? Icons.save_rounded : Icons.share,
                            color: Colors.white,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isPlanning ? "Save Route" : "Share Route",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: child,
    );
  }
}

class PlanningCard extends StatelessWidget {
  const PlanningCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Wrap(
        children: const [
          LocationButton(
            index: 1,
            name: "Source",
          ),
          Divider(
            height: 20,
            thickness: .6,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          LocationButton(
            index: 2,
            name: "Destination",
          ),
        ],
      ),
    );
  }
}
