import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/map_provider.dart';
import 'package:geo_app/components/special_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlanRoute extends HookWidget {
  const PlanRoute({
    Key? key,
    required this.onRemove,
  }) : super(key: key);

  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final height = useState(0.0);
    final enlarge = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Wrap(
        children: [
          GestureDetector(
            onTap: () {
              enlarge.value = !enlarge.value;
              height.value = enlarge.value ? 400 : 0;
            },
            child: SpecialCard(
              backgroundColor: Colors.blue,
              shadowColor: Colors.transparent,
              height: 60,
              borderRadius: !enlarge.value ? BorderRadius.circular(10) : const BorderRadius.vertical(top: Radius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.route,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Text(
                      "Plan Route",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onRemove,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.close_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 750),
            height: height.value,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
