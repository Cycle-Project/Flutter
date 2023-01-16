import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/Components/location_dialog.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class LocationButton extends HookWidget {
  const LocationButton({
    Key? key,
    required this.name,
    required this.index,
  }) : super(key: key);
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final planProvider = Provider.of<PlanRouteProvider>(context);
    final text = useState("");

    dialog(context, index) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: mapsProvider),
              ChangeNotifierProvider.value(value: planProvider),
            ],
            child: LocationDialog(
              index: index,
            ),
          ),
        ),
      );
    }

    useEffect(
      () {
        text.value = index == 1
            ? planProvider.isSourcePinned
                ? "Current Location"
                : planProvider.source?.toJson().toString() ?? ""
            : planProvider.isDestinationPinned
                ? "Current Location"
                : planProvider.destination?.toJson().toString() ?? "";

        return null;
      },
      index == 1
          ? [
              planProvider.source,
              planProvider.isSourcePinned,
            ]
          : [
              planProvider.destination,
              planProvider.isDestinationPinned,
            ],
    );

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => dialog(context, index),
            child: SizedBox(
              height: 50,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${index == 1 ? "Source" : "Destination"} Location",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .65,
                            maxHeight: 20,
                          ),
                          child: Text(
                            text.value == "" ? "-" : text.value,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment(0, .7),
                      child: Icon(
                        Icons.edit_location_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: text.value != "",
          child: InkWell(
            onTap: () => index == 1
                ? planProvider.setSource(newSorce: null)
                : planProvider.setDestination(newDestination: null),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment(0, .7),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
