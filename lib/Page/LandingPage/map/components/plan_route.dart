import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';

class PlanRoute extends HookWidget {
  const PlanRoute({
    Key? key,
    required this.size,
    required this.enlargedSize,
    required this.onTap,
    required this.onBack,
  }) : super(key: key);

  final Size size, enlargedSize;
  final Function(bool) onTap;
  final bool onBack;

  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    final currentSize = useState(size);
    const fadeTime = 250;

    return InkWell(
      onTap: onBack ? null : () {
        isOpen.value = !isOpen.value;
        onTap(isOpen.value);
        currentSize.value = isOpen.value ? enlargedSize : size;
      },
      child: MapCard(
        fadeTime: fadeTime,
        backgroundColor: Colors.blue,
        size: currentSize.value,
        text: "Plan",
        prefix: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.route,
              size: 20,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
/* if (pageState.value == PlanPages.first)
          Container(
            color: Colors.lightGreen,
            height: 150,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => _ListItem(
                  indexText: index == 0 ? "A: " : "B: ",
                  indexDestination: index == 0
                      ? chooseStartLabel.value
                      : chooseDestinationLabel.value,
                  onTap: () {
                    pageState.value = PlanPages.second;
                    pinIndex.value = index;
                  }),
            ),
          ),
        if (pageState.value == PlanPages.second)
          Container(
            height: 160,
            color: Colors.lightGreen,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimSearchBar(
                    width: 400,
                    color: Colors.white,
                    helpText: "Place or Address",
                    textController: textSearchController,
                    onSuffixTap: () {
                      textSearchController.clear();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _CircleIconButton(
                        icon:
                            const Icon(Icons.my_location, color: Colors.black),
                        onPressed: () {
                          if (pinIndex.value == 0) {
                            /// source
                            (mapsProvider.mapAction as PlanRouteProvider)
                              ..state = MyState.PinStart
                              ..sourceLocation = PositionModel.fromLocationData(
                                  mapsProvider.currentLocation!);
                          } else if (pinIndex.value == 1) {
                            /// destination
                            (mapsProvider.mapAction as PlanRouteProvider)
                              ..state = MyState.PinEnd
                              ..destination = PositionModel.fromLocationData(
                                  mapsProvider.currentLocation!);
                          }
                          chooseStartLabel.value = "Current Location";
                          chooseDestinationLabel.value = "Current Location";
                          pageState.value = PlanPages.first;
                        },
                      ),
                      _CircleIconButton(
                        icon: const Icon(Icons.map, color: Colors.blue),
                        onPressed: () {
                          (mapsProvider.mapAction as PlanRouteProvider)
                              .isDestination = false;
                          chooseStartLabel.value = "Waypoint";
                          chooseDestinationLabel.value = "Current Location";
                          pageState.value = PlanPages.first;
                        },
                      ),
                      const _CircleIconButton(
                        icon: Icon(Icons.favorite, color: Colors.green),
                      ),
                      _CircleIconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          pageState.value = PlanPages.first;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) */

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white70,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  _ListItem({
    Key? key,
    required this.indexText,
    required this.indexDestination,
    required this.onTap,
  }) : super(key: key);

  final indexText;
  final indexDestination;
  final Function() onTap;

  TextStyle style = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(indexText, style: style),
        const SizedBox(width: 15),
        GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
              ),
              width: MediaQuery.of(context).size.width * .5,
              child: Container(
                margin: const EdgeInsets.only(left: 12.0),
                child: Text(indexDestination,
                    textAlign: TextAlign.start, style: style),
              ),
            )),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.headset_off_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
