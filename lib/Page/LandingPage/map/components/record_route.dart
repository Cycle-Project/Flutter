import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:geo_app/components/special_card.dart';
import 'package:provider/provider.dart';

class RecordRoute extends HookWidget {
  const RecordRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = RecordRouteProvider(mapsProvider: mapsProvider);

    return ChangeNotifierProvider(
      create: (_) {
        mapsProvider.mapAction = provider;
        return provider;
      },
      child: GestureDetector(
        onTap: () async {
          await provider.changeRecordingStatus();
          mapsProvider.mapAction =
              RecordRouteProvider(mapsProvider: mapsProvider);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SpecialCard(
            backgroundColor: Colors.red,
            shadowColor: Colors.transparent,
            height: 60,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        provider.record ? Icons.pause : Icons.circle,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      provider.record ? "Recording..." : "Record My Route",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
