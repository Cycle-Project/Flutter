import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_sublist.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';

class ProfileFavorites extends StatelessWidget {
  const ProfileFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      name: "Favorites",
      prefixIcon: Icons.favorite,
      onTap: () {
        List list = List.generate(20, (i) => "Favorite ${i + 1}");
        if (list.isNotEmpty) {
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => ProfileSubList(
              list: list,
              title: "Favorites",
            ),
          );
        }
      },
    );
  }
}
