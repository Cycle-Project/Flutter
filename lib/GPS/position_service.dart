// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/landing_page.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:provider/provider.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapsProvider = MapsProvider();
    final planProvider = PlanRouteProvider(mapsProvider: mapsProvider);
    final recordProvider = RecordRouteProvider(mapsProvider: mapsProvider);
    final friendsController = FriendsController();

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
        ChangeNotifierProvider(create: (_) => recordProvider),
        ChangeNotifierProvider(create: (_) => friendsController),
      ],
      child: LandingPage(),
    );
  }
}
