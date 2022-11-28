import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/special_card.dart';

part 'components/profile_card.dart';
part 'components/action_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionList = [
      {
        "name": "Routes",
        "icon": Icons.route,
        "call": () {},
        "list": [
          "fav1",
          "fav2",
          "fav3",
        ],
      },
      {
        "name": "Favorites",
        "icon": Icons.favorite,
        "call": () {},
        "list": [
          "fav1",
          "fav2",
          "fav3",
        ],
      },
    ];
    return Column(
      children: [
        const _ProfileCard(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                actionList.length,
                (i) {
                  Map map = actionList[i];
                  return _ActionWidget(
                    onTap: () => map["call"],
                    name: map["name"],
                    prefixIcon: Icon(map["icon"]),
                    list: map["list"],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
