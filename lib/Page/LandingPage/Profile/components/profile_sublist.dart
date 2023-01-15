import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/map/inspect_route_bottom_sheet.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;
import 'package:provider/provider.dart';

class ProfileSubList extends StatelessWidget {
  const ProfileSubList({
    Key? key,
    required this.list,
    required this.title,
  }) : super(key: key);

  final List<r.Route> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    setProviderValues(int i) async {
      if (list[i].positions == null) return;
      mapsProvider.polylineCoordinates =
          list[i].positions!.map((e) => e.toLatLng()).toList();
      provider.setSource(
        newSorce: list[i].positions![0],
      );
      provider.setDestination(
        newDestination: list[i].positions![list[i].positions!.length - 1],
      );
      await Future.delayed(const Duration(milliseconds: 10));
    }

    return Scaffold(
      backgroundColor: Constants.darkBluishGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(title),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => InkWell(
            onTap: () async {
              await setProviderValues(i);
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: mapsProvider),
                    ChangeNotifierProvider.value(value: provider),
                  ],
                  child: InspectRouteBottomSheet(
                    isPlanning: false,
                    route: list[i],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 100,
                    child: ColoredBox(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        list[i].title ?? "Route",
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
