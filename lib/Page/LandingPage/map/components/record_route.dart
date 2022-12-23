import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:provider/provider.dart';

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
    final recordProvider = Provider.of<RecordRouteProvider>(context);
    final record = useState(false);
    final currentSize = useState(size);
    const fadeTime = 150;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onBack
            ? null
            : () {
                record.value = !record.value;
                recordProvider.changeRecordingStatus(isRecording: record.value);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text("Record :${record.value}"),
                  ),
                );
                onTap(record.value);
                currentSize.value = record.value ? enlargedSize : size;
              },
        child: ClipRect(
          clipBehavior: Clip.hardEdge,
          child: MapCard(
            fadeTime: fadeTime,
            backgroundColor: Colors.red,
            size: currentSize.value,
            child: _RecordChild(isOpen: record.value),
          ),
        ),
      ),
    );
  }
}

class _RecordChild extends StatelessWidget {
  const _RecordChild({
    Key? key,
    required this.isOpen,
  }) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordRouteProvider>(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox.expand(),
        Align(
          alignment: const Alignment(-1, 0),
          child: Row(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    isOpen ? Icons.pause : Icons.circle,
                    size: isOpen ? 30 : 20,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  isOpen ? "Recording..." : "Record",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
