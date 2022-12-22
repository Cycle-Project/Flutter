import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';
import 'package:lottie/lottie.dart';

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
    const fadeTime = 150;

    return InkWell(
      onTap: onBack
          ? null
          : () {
              record.value = !record.value;
              onTap(record.value);
              currentSize.value = record.value ? enlargedSize : size;
            },
      child: MapCard(
        fadeTime: fadeTime,
        backgroundColor: Colors.red,
        size: currentSize.value,
        /*prefix: ,
        text: ,*/
        child: _RecordChild(isOpen: record.value),
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox.expand(),
        Positioned(
          top: 0,
          bottom: 0,
          left: -50,
          child: AnimatedScale(
            scale: 4,
            duration: Duration(milliseconds: 1),
            child: Lottie.asset(
              "assets/lottie/109393-recording.json",
              width: 200,
              height: 200,
            ),
          ),
        ),
        Align(
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  //Lottie.asset("assets/lottie/109393-recording.json")
                  child: Icon(
                    isOpen ? Icons.pause : Icons.circle,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 20),
              const Expanded(
                child: Text(
                  "Record",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
