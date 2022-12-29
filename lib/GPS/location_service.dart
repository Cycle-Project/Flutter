import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/GPS/position_service.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:location/location.dart';

Location location = Location();

class LocationService extends HookWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceEnabled = useState<bool>(false);
    final permissionGranted = useState<bool>(false);

    useEffect(() {
      Future.microtask(() async {
        serviceEnabled.value = await location.serviceEnabled();
        if (!serviceEnabled.value) {
          serviceEnabled.value = await location.requestService();
          if (!serviceEnabled.value) return;
        }

        PermissionStatus permission = await location.hasPermission();
        if (permission == PermissionStatus.deniedForever) return;
        if (permission == PermissionStatus.denied) {
          permission = await location.requestPermission();
          if (permission == PermissionStatus.denied) return;
          permissionGranted.value = true;
        }
        permissionGranted.value = true;
      });
      return () {};
    }, [permissionGranted, serviceEnabled]);

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: permissionGranted.value && serviceEnabled.value
          ? const PositionService()
          : const SizedBox(),
    );
  }
}
