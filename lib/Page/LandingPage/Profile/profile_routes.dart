import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;
import 'package:geo_app/Page/LandingPage/Profile/components/profile_sublist.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/LandingPage/map/route_mixin.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:provider/provider.dart';

class ProfileRoutes extends StatelessWidget with RouteMixin {
  ProfileRoutes({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final provider = Provider.of<PlanRouteProvider>(context);

    return ProfileWidget(
      name: "Routes",
      prefixIcon: Icons.route,
      onTap: () => showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mapsProvider),
            ChangeNotifierProvider.value(value: provider),
          ],
          child: FutureBuilder(
              future: getRoutesOf(context, userId),
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Scaffold(
                    backgroundColor: Constants.darkBluishGreyColor,
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                        backgroundColor: Constants.tealColor,
                      ),
                    ),
                  );
                }
                List<r.Route> list = snap.data as List<r.Route>;
                return ProfileSubList(
                  list: list,
                  title: "Routes",
                );
              }),
        ),
      ),
    );
  }
}
