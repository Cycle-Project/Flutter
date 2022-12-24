import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/plan_route.dart';
import 'package:geo_app/Page/LandingPage/map/components/record_route.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:provider/provider.dart';

class MapPage extends HookWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final size = MediaQuery.of(context).size;
    final smallSize = Size(size.width * .5 - 14, 60);
    final mediumSize = Size(size.width, size.height * .32);
    final largeSize = Size(size.width, size.height * .7);
    final opened = useState(0);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlanRouteProvider(mapsProvider: mapsProvider),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => RecordRouteProvider(mapsProvider: mapsProvider),
          lazy: true,
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          MapWidget(
            shouldAddMark: (latLng) {
              return opened.value == 2;
            },
            shouldClearMark: opened.value != 2,
          ),
          AnimatedOpacity(
            opacity: opened.value != 2 ? 1 : 0,
            duration: const Duration(milliseconds: 100),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: RecordRoute(
                onBack: opened.value == 2,
                enlargedSize: mediumSize,
                size: smallSize,
                onTap: (open) {
                  opened.value = open ? 1 : 0;
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: opened.value != 1 ? 1 : 0,
            duration: const Duration(milliseconds: 100),
            child: Align(
              alignment: Alignment.bottomRight,
              child: PlanRoute(
                onBack: opened.value == 1,
                enlargedSize: mediumSize,
                size: smallSize,
                onTap: (open) {
                  opened.value = open ? 2 : 0;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
