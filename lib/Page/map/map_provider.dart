import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  final ValueNotifier<LocationData?> locationData;

  MapsProvider({
    required this.locationData,
  });
}
