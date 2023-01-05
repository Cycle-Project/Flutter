import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Community/group_card.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_page.dart';
import 'package:geo_app/components/header.dart';

class CommunityPage extends HookWidget {
  const CommunityPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = useState<List?>(null);

    useEffect(() {
      list.value = [
        {
          "groupName": "VelEsbid",
          "imagePath": "assets/icon/velesbid.jpg",
          "members": [
            "Turan",
            "Ömer",
            "Fatih",
            "Yahya",
            "Faruk",
            "Burhan",
            "Beşir",
            "Hatim"
          ],
        },
        {
          "groupName": "Muğla Bisiklet Derneği",
          "imagePath": "assets/icon/mugla-bisiklet-derneği.jpg",
          "members": ["Ali", "Veli", "Selami"],
        },
      ];
      return null;
    }, []);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Header(title: "Groups", color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: list.value?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) => list.value?[i] == null
                ? const SizedBox()
                : GroupCard(
                    item: list.value![i],
                    color: Colors.green.shade900,
                  ),
            separatorBuilder: (context, i) =>
                const Divider(color: Colors.black),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Header(title: "Discover", color: Colors.white),
        ),
        const Discover(),
      ],
    );
  }
}
