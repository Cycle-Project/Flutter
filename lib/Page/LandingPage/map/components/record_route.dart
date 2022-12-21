import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';

class RecordRoute extends HookWidget {
  const RecordRoute({
    Key? key,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    final record = useState(false);

    return InkWell(
      onTap: () {
        record.value = !record.value;
        onTap(record.value);
      },
      child: MapCard(
        fadeTime: 200,
        backgroundColor: Colors.red,
        size: size,
        prefix: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              record.value ? Icons.pause : Icons.circle,
              size: 20,
              color: Colors.red,
            ),
          ),
        ),
        text: record.value ? "Recording..." : "Record",
      ),
    );
  }
}
