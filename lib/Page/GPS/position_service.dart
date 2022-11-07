import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Record/record_button.dart';
import 'package:geo_app/Page/map/map_provider.dart';
import 'package:geo_app/Page/map/map_widget.dart';
import 'package:provider/provider.dart';

class PositionService extends HookWidget {
  const PositionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapsProvider(),
      child: Builder(
        builder: (context) {
          if (Provider.of<MapsProvider>(context).currentLocation == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return Stack(
            children: [
              ColoredBox(
                color: const Color.fromARGB(255, 171, 171, 171),
                child: MapWidget(),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: RecordButton(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
