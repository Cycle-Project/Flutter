import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/circle_icon_button.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class LocationDialog extends HookWidget {
  const LocationDialog({
    Key? key,
    required this.index,
    required this.callback,
  }) : super(key: key);

  final int index;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    final planProvider = Provider.of<PlanRouteProvider>(context);
    final textSearchController = useTextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: AnimSearchBar(
            closeSearchOnSuffixTap: true,
            autoFocus: true,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            helpText: "Place or Address",
            textController: textSearchController,
            onSuffixTap: () {
              textSearchController.clear();
            },
            onSubmitted: (String a) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleIconButton(
                icon: const Icon(Icons.my_location, color: Colors.black),
                onPressed: () {
                  switch (index) {
                    case 1:
                      planProvider.setSource(isPinned: true);
                      break;
                    case 2:
                      planProvider.setDestination(isPinned: true);
                      break;
                    default:
                  }
                  callback("Current Location");
                },
              ),
              CircleIconButton(
                icon: const Icon(Icons.map, color: Colors.blue),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
