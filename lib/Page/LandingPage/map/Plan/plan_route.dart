import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/plan_button.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';

class PlanRoute extends HookWidget {
  const PlanRoute({
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
    final isOpen = useState(false);
    final currentSize = useState(size);
    const fadeTime = 250;

    tap() {
      isOpen.value = !isOpen.value;
      onTap(isOpen.value);
      currentSize.value = isOpen.value ? enlargedSize : size;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onBack || isOpen.value ? null : tap,
        child: MapCard(
          fadeTime: fadeTime,
          backgroundColor: Colors.blue,
          size: currentSize.value,
          child: _PlanChild(
            isOpen: isOpen.value,
            onTap: tap,
            onClose: tap,
          ),
        ),
      ),
    );
  }
}

class _PlanChild extends HookWidget {
  const _PlanChild({
    Key? key,
    required this.isOpen,
    required this.onTap,
    required this.onClose,
  }) : super(key: key);
  final bool isOpen;
  final Function() onTap, onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox.expand(),
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Visibility(
            visible: isOpen,
            child: Column(
              children: const [
                LocationButton(
                  index: 1,
                  name: "Source",
                ),
                SizedBox(height: 20),
                LocationButton(
                  index: 2,
                  name: "Destination",
                ),
              ],
            ),
          ),
        ),
        AnimatedAlign(
          alignment: const Alignment(0, .85),
          duration: const Duration(milliseconds: 300),
          child: Row(
            children: [
              if (isOpen)
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: onClose,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                            Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 7,
                child: InkWell(
                  onTap: onTap,
                  child: PlanButton(isOpen: isOpen),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
