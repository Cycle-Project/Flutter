import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';

class RecordRoute extends HookWidget {
  const RecordRoute({
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
    final record = useState(false);
    final currentSize = useState(size);
    const fadeTime = 250;

    return InkWell(
      onTap: onBack ? null : () {
        record.value = !record.value;
        onTap(record.value);
        currentSize.value = record.value ? enlargedSize : size;
      },
      child: MapCard(
        fadeTime: fadeTime,
        backgroundColor: Colors.red,
        size: currentSize.value,
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
