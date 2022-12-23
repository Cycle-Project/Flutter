import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/map_card.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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

class _PlanChild extends HookWidget {
  const _PlanChild({
    Key? key,
    required this.isOpen,
    required this.onTap,
    required this.onClose,
  }) : super(key: key);
  final bool isOpen;
  final Function() onTap, onClose;

  dialog(context, index) {
    String? returnValue = "";
    showGeneralDialog(
      context: context,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => Scaffold(
        appBar: AppBar(
          title: Text(index == 1 ? "Source" : "Destination"),
        ),
        body: index == 1
            ? _SourceLocation(
                sourceLocationDelegate: (str) {
                  Navigator.of(context).pop(str);
                },
              )
            : _DestinationLocation(),
      ),
    ).then((value) => returnValue = value.toString());
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    final sourceText = useState("");
    final destinationText = useState("");
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
                  onTap: () {
                    sourceText.value = dialog(context, 1);
                  },
                  child: _LocationButton(
                    name: "Source",
                    text: sourceText.value,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    destinationText.value = dialog(context, 2);
                  },
                  child: _LocationButton(
                    name: "Destination",
                    text: destinationText.value,
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
    required this.text,
  }) : super(key: key);
  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController(text: text);
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

class _SourceLocation extends StatelessWidget {
  _SourceLocation({
    Key? key,
    required this.sourceLocationDelegate,
  }) : super(key: key);

  TextEditingController textSearchController = TextEditingController();
  final Function(String) sourceLocationDelegate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: AnimSearchBar(
            closeSearchOnSuffixTap: true,
            autoFocus: true,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            helpText: "Place or Address",
            textController: textSearchController,
            onSuffixTap: () {
              textSearchController.clear();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CircleIconButton(
                  icon: const Icon(Icons.my_location, color: Colors.black),
                  onPressed: () {
                    sourceLocationDelegate("Konum");
                  }),
              _CircleIconButton(
                  icon: const Icon(Icons.map, color: Colors.blue),
                  onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class _DestinationLocation extends StatelessWidget {
  const _DestinationLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text("destination location"),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.greenAccent,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
