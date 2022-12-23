import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';
import 'package:lottie/lottie.dart';

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

    return InkWell(
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
    );
  }
}

class _PlanChild extends StatelessWidget {
  const _PlanChild({
    Key? key,
    required this.isOpen,
    required this.onTap,
    required this.onClose,
  }) : super(key: key);
  final bool isOpen;
  final Function() onTap, onClose;

  dialog(context, index) {
    return showGeneralDialog(
      context: context,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => Scaffold(
        appBar: AppBar(
          title: Text(index == 1 ? "Source" : "Destination"),
        ),
        body: Text(index.toString()),
      ),
    );
  }

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
              children: [
                InkWell(
                  onTap: () => dialog(context, 1),
                  child: _LocationButton(
                    name: "Source",
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => dialog(context, 2),
                  child: _LocationButton(
                    name: "Destination",
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, .72),
          child: Visibility(
            visible: isOpen,
            child: InkWell(
              onTap: onClose,
              child: Row(
                children: const [
                  SizedBox(width: 10),
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
        AnimatedAlign(
          alignment: isOpen ? Alignment(.75, .85) : Alignment(0, 1),
          duration: Duration(milliseconds: 300),
          child: InkWell(
            onTap: onTap,
            child: _PlanButton(isOpen: isOpen),
          ),
        ),
      ],
    );
  }
}

class _LocationButton extends HookWidget {
  const _LocationButton({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    return SizedBox(
      height: 50,
      child: TextField(
        enabled: false,
        controller: _controller,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: name,
            labelStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _PlanButton extends StatelessWidget {
  const _PlanButton({
    Key? key,
    required this.isOpen,
  }) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOpen ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 180,
        child: Row(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(isOpen ? 15 : 10),
                child: Icon(
                  Icons.route,
                  size: isOpen ? 35 : 20,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Plan",
                    style: TextStyle(
                      fontSize: 20,
                      color: isOpen ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
