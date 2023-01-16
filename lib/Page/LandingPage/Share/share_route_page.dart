import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:provider/provider.dart';

class ShareRoutePage extends HookWidget {
  const ShareRoutePage({super.key, required this.route});
  final r.Route route;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<PlanRouteProvider>(context);
    final mapsProvider = Provider.of<MapsProvider>(context);
    final titleController = useTextEditingController();
    final notesController = useTextEditingController();

    share() {
      /// TODO Share
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Constants.darkBluishGreyColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Wrap(
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: mapsProvider),
                        ChangeNotifierProvider.value(value: provider),
                      ],
                      child: Dialog(
                        child: SizedBox.square(
                          dimension: size.width > size.height
                              ? size.height
                              : size.width,
                          child: MapWidget(
                            shouldClearMark: true,
                            shouldAddMark: (latLng) => false,
                            gesturesEnabled: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "See Route",
                      style: TextStyle(
                        fontSize: 16,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _Field(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
            ),
            _Field(
              child: TextField(
                controller: notesController,
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Notes",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: share,
                child: Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: const Center(
                    child: Text(
                      "Share",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
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

class _Field extends StatelessWidget {
  const _Field({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
