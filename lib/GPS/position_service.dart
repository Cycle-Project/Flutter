// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/landing_page.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapsProvider = MapsProvider();
    final planProvider = PlanRouteProvider(mapsProvider: mapsProvider);

    useEffect(() {
      final subscription = mapsProvider.listenLocation();
      return () {
        subscription.cancel();
      };
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => mapsProvider),
        ChangeNotifierProvider(create: (_) => planProvider),
      ],
      child: const LandingPage(),
    );
  }
}
