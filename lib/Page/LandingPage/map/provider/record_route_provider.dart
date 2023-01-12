import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_act.dart';
import 'package:location/location.dart';

class RecordRouteProvider extends MapAction {
  late bool record;
  DateTime? startTime;

  RecordRouteProvider({
    this.record = false,
    this.startTime,
    required super.mapsProvider,
  });

  changeRecordingStatus({bool? isRecording, DateTime? timeStart}) async {
    record = isRecording ?? !record;
    startTime = timeStart;
    if (!record || mapsProvider.currentLocation == null) {
      source = null;
      destination = null;
      mapsProvider.polylineCoordinates = [];
    } else {
      mapsProvider.mapAction = this;
      source = destination = Position.fromLocationData(
        mapsProvider.currentLocation!,
      );
    }
    notifyListeners();
  }

  getTimePasseed() {
    if (startTime == null) {
      throw Exception("Recording didn't started or Start time did't setted!");
    }
    return DateTimeRange(
      start: startTime!,
      end: DateTime.now(),
    ).duration;
  }

  @override
  onLocationChanged(LocationData? currentLocation) async {
    if (record) {
      destination = Position.fromLocationData(currentLocation!);
      // TODO : send destination to service
      await getPolyPoints();
    }
  }
}
