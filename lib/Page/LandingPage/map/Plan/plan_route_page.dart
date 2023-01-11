import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/plan_route_custom_dialog.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';

///mapIndexed
import 'package:provider/provider.dart';

class PlanPage extends HookWidget {
  PlanPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;



  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    plan() async {
      await showDialog(
        context: context,
        builder: (_) => PlanRouteCustomDialog(
          provider: provider,
          mapsProvider: mapsProvider,
        ),
      );
    }

    bottomSheet(context) async {
      await Future.delayed(const Duration(milliseconds: 100));
      await showModalBottomSheet(
        context: context,
        backgroundColor: Constants.darkBluishGreyColor,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mapsProvider),
            ChangeNotifierProvider.value(value: provider),
          ],
          child: Wrap(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Divider(
                      height: 16,
                      thickness: 2,
                      color: Constants.primaryColor.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 8),
                          child: Icon(
                            Icons.close,
                            size: 28,
                            color: Constants.primaryColor.withOpacity(.6),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
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
              ),
              //if (provider.source != null && provider.destination != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: InkWell(
                  onTap: plan,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Constants.primaryColor.withOpacity(.8),
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(Icons.route, color: Colors.white, size: 26),
                        SizedBox(width: 12),
                        Text(
                          "Plan",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    useEffect(() {
      bottomSheet(context);
      return null;
    }, []);

    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: [
          SizedBox.expand(
            child: MapWidget(
              shouldClearMark: false,
              shouldAddMark: (_) => false,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.darkBluishGreyColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () async => await bottomSheet(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Constants.darkBluishGreyColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 50,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
