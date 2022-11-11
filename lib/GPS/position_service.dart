// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/landing_page.dart';
import 'package:geo_app/Page/LandingPage/map/map_provider.dart';
import 'package:provider/provider.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = MapsProvider();

    useEffect(() {
      final subscription = provider.listenLocation();
      return () {
        subscription.cancel();
      };
    });

    return ChangeNotifierProvider(
      create: (_) => provider,
      child: LandingPage(),
    );
  }
}
