import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/inspect_route_bottom_sheet.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';

///mapIndexed
import 'package:provider/provider.dart';

class PlanPage extends HookWidget {
  const PlanPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    bottomSheet(context) async {
      await Future.delayed(const Duration(milliseconds: 100));
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mapsProvider),
            ChangeNotifierProvider.value(value: provider),
          ],
          child: InspectRouteBottomSheet(isPlanning: true),
        ),
      );
    }

    useEffect(() {
      bottomSheet(context);
      return null;
    }, []);

    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: [
          SizedBox.expand(
            child: MapWidget(
              shouldClearMark: false,
              shouldAddMark: (_) => false,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.darkBluishGreyColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () async => await bottomSheet(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Constants.darkBluishGreyColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 50,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
