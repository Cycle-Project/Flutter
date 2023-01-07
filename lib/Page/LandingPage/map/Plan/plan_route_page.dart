import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/location_button.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class PlanPage extends HookWidget {
  const PlanPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanRouteProvider>(context);
    plan() {}

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text("Planing a route"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        LocationButton(
                          index: 1,
                          name: "Source",
                        ),
                        Divider(
                          height: 20,
                          thickness: .6,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.grey,
                        ),
                        LocationButton(
                          index: 2,
                          name: "Destination",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              if (provider.source != null && provider.destination != null)
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () => plan(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.route_outlined,
                            color: color,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Plan",
                              style: TextStyle(
                                fontSize: 24,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
