import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/plan_route.dart';
import 'package:geo_app/Page/LandingPage/map/components/record_route.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';

class MapPage extends HookWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallSize = Size(size.width * .5 - 14, 60);
    final mediumSize = Size(size.width, 200);

    final recordSize = useState(smallSize);
    final planSize = useState(smallSize);
    final opened = useState(0);

    return Stack(
      fit: StackFit.expand,
      children: [
        MapWidget(),
        Visibility(
          visible: opened.value != 2,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: RecordRoute(
              size: recordSize.value,
              onTap: (open) {
                opened.value = open ? 1 : 0;
                recordSize.value = open ? mediumSize : smallSize;
              },
            ),
          ),
        ),
        Visibility(
          visible: opened.value != 1,
          child: Align(
            alignment: Alignment.bottomRight,
            child: PlanRoute(
              size: planSize.value,
              onTap: (open) {
                opened.value = open ? 2 : 0;
                planSize.value = open ? size : smallSize;
              },
            ),
          ),
        ),
      ],
    );
  }
}
