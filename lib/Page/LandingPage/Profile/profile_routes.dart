import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_sublist.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';

class ProfileRoutes extends StatelessWidget {
  const ProfileRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      name: "Routes",
      prefixIcon: Icons.route,
      onTap: () {
        List list = List.generate(20, (i) => "Route ${i + 1}");
        if (list.isNotEmpty) {
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => ProfileSubList(
              list: list,
              title: "Routes",
            ),
          );
        }
      },
    );
  }
}
