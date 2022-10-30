import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*onRecordButton() async {
      mapsProvider.record = !mapsProvider.record;
      if (mapsProvider.record && mapsProvider.currentLocation != null) {
        PositionModel locat = PositionModel.fromJson(
            {'latitude': 39.753226, 'longitude': 30.493691});
        mapsProvider.sourceLocation = locat;
        mapsProvider.destination =
            PositionModel.fromLocationData(mapsProvider.currentLocation!);
      } else {
        mapsProvider.sourceLocation = PositionModel();
        mapsProvider.destination = PositionModel();
      }
      await mapsProvider.getPolyPoints();
    }*/

    return GestureDetector(
      onTap: () {}, // async => await onRecordButton(),
      child: SizedBox.square(
        dimension: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 203, 197, 197),
            borderRadius: BorderRadius.circular(80),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80),
              ),
              child: Icon(
                (false) ? Icons.rectangle_rounded : Icons.circle,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
