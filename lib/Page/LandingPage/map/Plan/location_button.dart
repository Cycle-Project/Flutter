import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_dialog.dart';
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
  dialog(context, index) async {
    String returnValue = "";
    await showGeneralDialog(
      context: context,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Provider.of<MapsProvider>(context),
          ),
          ChangeNotifierProvider.value(
            value: Provider.of<PlanRouteProvider>(context),
          ),
        ],
        child: LocationDialog(
          index: index,
          callback: (str) => Navigator.of(context).pop(str),
        ),
      ),
    ).then((value) => returnValue = value.toString());
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    final text = useState("Your Current sadsadasd");

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              text.value = await dialog(context, index);
            },
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${index == 1 ? "Source" : "Destination"} Location",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        text.value == "" ? "-" : text.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
            onTap: () => text.value = "",
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
