import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Components/user_action.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_action_card.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/plan_route_page.dart';
import 'package:geo_app/Page/LandingPage/map/Record/record_route_page.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/header.dart';
import 'package:provider/provider.dart';

class UserActions extends StatelessWidget {
  const UserActions({super.key});

  @override
  Widget build(BuildContext context) {
    final mapsProvider = Provider.of<MapsProvider>(context);
    final planProvider = Provider.of<PlanRouteProvider>(context);
    final recordProvider = Provider.of<RecordRouteProvider>(context);
    final list = [
      UserAction(
        color: Colors.red.shade400,
        iconData: Icons.circle,
        headerText: "Record",
        child: (color) => ChangeNotifierProvider.value(
          value: recordProvider,
          child: RecordPage(color: color),
        ),
      ),
      UserAction(
        color: Constants.generateMaterialColor(
          Constants.lilaColor,
        ).shade400,
        iconData: Icons.route,
        headerText: "Plan",
        child: (color) => ChangeNotifierProvider.value(
          value: planProvider,
          child: PlanPage(color: color),
        ),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Header(title: "Actions", color: Colors.white),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, i) {
              UserAction item = list[i];
              return UserActionCard(
                color: item.color,
                onTap: (color) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: mapsProvider,
                        child: item.child(color),
                      ),
                    ),
                  );
                },
                icon: (color) => CircledIcon(
                  color: item.color,
                  iconData: item.iconData,
                  size: 28,
                  padding: const EdgeInsets.all(12),
                ),
                headerText: item.headerText,
              );
            },
          ),
        ],
      ),
    );
  }
}
