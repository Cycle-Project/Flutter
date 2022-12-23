import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_dialog.dart';
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
      pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
        value: Provider.of<PlanRouteProvider>(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text(index == 1 ? "Source" : "Destination"),
          ),
          body: LocationDialog(
            index: index,
            callback: (str) {
              Navigator.of(context).pop(str);
            },
          ),
        ),
      ),
    ).then((value) => returnValue = value.toString());
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isVisible = useState(false);

    return Stack(
      children: [
        InkWell(
          onTap: () async {
            controller.text = await dialog(context, index);
            isVisible.value = controller.text != "";
          },
          child: SizedBox(
            height: 50,
            child: TextFormField(
              enabled: false,
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                labelText: name,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 10,
          child: Visibility(
            visible: isVisible.value,
            child: InkWell(
              onTap: () {
                controller.text = "";
                isVisible.value = false;
              },
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
