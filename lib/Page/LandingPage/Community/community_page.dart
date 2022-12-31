import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Community/group_card.dart';
import 'package:geo_app/components/header.dart';

class CommunityPage extends HookWidget {
  const CommunityPage({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final list = useState<List?>(null);

    useEffect(() {
      list.value = [
        {
          "groupName": "Araç lazım mıdır efendim",
          "imagePath": "assets/icon/Avatar.png",
          "members": ["X", "Y", "Z"],
        },
        {
          "groupName": "Balıklar güzel hayvalardırlardırlardırlar",
          "imagePath": "assets/icon/Avatar.png",
          "members": [
            "S",
            "D",
            "C",
            "A",
            "Ehe",
            "S",
            "D",
            "C",
            "A",
            "Ehe",
            "S",
            "D",
            "C",
            "A",
            "Ehe"
          ],
        },
      ];
      return null;
    }, []);

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 32),
          )
        ],
      ),
      body: ListView(
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
              itemBuilder: (context, i) => list.value?[i] == null
                  ? const SizedBox()
                  : GroupCard(item: list.value![i], color: color),
              separatorBuilder: (context, i) =>
                  const Divider(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
